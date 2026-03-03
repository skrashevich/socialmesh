// SPDX-License-Identifier: GPL-3.0-or-later
// lint-allow: keyboard-dismissal — text fields use SearchFilterHeader which dismisses on scroll/filter
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/safety/lifecycle_mixin.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/animations.dart';
import '../../../core/widgets/app_bar_overflow_menu.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../../core/widgets/search_filter_header.dart';
import '../../../providers/auth_providers.dart';
import '../../../utils/snackbar.dart';
import '../models/shop_models.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../providers/admin_shop_providers.dart';
import '../providers/device_shop_providers.dart';

/// Admin screen for managing products
class AdminProductsScreen extends ConsumerStatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  ConsumerState<AdminProductsScreen> createState() =>
      _AdminProductsScreenState();
}

class _AdminProductsScreenState extends ConsumerState<AdminProductsScreen>
    with LifecycleSafeMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  DeviceCategory? _filterCategory;
  bool _showInactive = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(adminAllProductsProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GlassScaffold(
        resizeToAvoidBottomInset: false,
        title: context.l10n.adminProductsTitle,
        actions: [
          IconButton(
            icon: Icon(
              _showInactive ? Icons.visibility : Icons.visibility_off,
              color: _showInactive ? context.accentColor : null,
            ),
            onPressed: () => setState(() => _showInactive = !_showInactive),
            tooltip: _showInactive
                ? context.l10n.adminProductsHideInactive
                : context.l10n.adminProductsShowInactive,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToEdit(null),
            tooltip: context.l10n.adminProductsAddTooltip,
          ),
        ],
        slivers: [
          // Pinned search header with category filter
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchFilterHeaderDelegate(
              searchController: _searchController,
              searchQuery: _searchQuery,
              onSearchChanged: (value) => setState(() => _searchQuery = value),
              hintText: context.l10n.adminProductsSearchHint,
              textScaler: MediaQuery.textScalerOf(context),
              trailingControls: [
                PopupMenuButton<DeviceCategory?>(
                  icon: Icon(
                    Icons.filter_list,
                    color: _filterCategory != null ? context.accentColor : null,
                  ),
                  tooltip: context.l10n.adminProductsFilterTooltip,
                  onSelected: (category) =>
                      setState(() => _filterCategory = category),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: null,
                      child: Text(context.l10n.adminProductsAllCategories),
                    ),
                    ...DeviceCategory.values.map(
                      (cat) => PopupMenuItem(
                        value: cat,
                        child: Text(cat.displayLabel(context.l10n)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Products List
          productsAsync.when(
            data: (products) {
              var filtered = products.where((p) {
                if (!_showInactive && !p.isActive) return false;
                if (_filterCategory != null && p.category != _filterCategory) {
                  return false;
                }
                if (_searchQuery.isNotEmpty) {
                  final query = _searchQuery.toLowerCase();
                  return p.name.toLowerCase().contains(query) ||
                      p.sellerName.toLowerCase().contains(query) ||
                      p.description.toLowerCase().contains(query);
                }
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: context.textTertiary,
                        ),
                        const SizedBox(height: AppTheme.spacing16),
                        Text(context.l10n.adminProductsNotFound),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = filtered[index];
                    return _ProductListItem(
                      product: product,
                      onEdit: () => _navigateToEdit(product),
                      onToggleActive: () => _toggleActive(product),
                      onDelete: () => _confirmDelete(product),
                    );
                  }, childCount: filtered.length),
                ),
              );
            },
            loading: () => SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Text(context.l10n.commonErrorWithDetails('$e')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEdit(ShopProduct? product) {
    if (product != null) {
      ref.read(productFormProvider.notifier).loadProduct(product);
    } else {
      ref.read(productFormProvider.notifier).reset();
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AdminProductEditScreen(product: product),
      ),
    );
  }

  Future<void> _toggleActive(ShopProduct product) async {
    // Capture providers before async gap
    final service = ref.read(deviceShopServiceProvider);
    final user = ref.read(currentUserProvider);

    try {
      if (product.isActive) {
        await service.deactivateProduct(product.id, adminId: user?.uid);
      } else {
        await service.reactivateProduct(product.id, adminId: user?.uid);
      }
      if (!mounted) return;
      ref.invalidate(adminAllProductsProvider);
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(
          context,
          context.l10n.deviceShopErrorWithDetails('$e'),
        );
      }
    }
  }

  Future<void> _confirmDelete(ShopProduct product) async {
    // Capture providers before async gap
    final service = ref.read(deviceShopServiceProvider);
    final l10n = context.l10n;

    final confirmed = await AppBottomSheet.showConfirm(
      context: context,
      title: l10n.adminProductsDeleteTitle,
      message: l10n.adminProductsDeleteMessage(product.name),
      confirmLabel: l10n.adminProductsDelete,
      isDestructive: true,
    );

    if (confirmed == true && mounted) {
      try {
        await service.deleteProductPermanently(product.id);
        if (!mounted) return;
        ref.invalidate(adminAllProductsProvider);
        showSuccessSnackBar(context, l10n.adminProductsDeleted);
      } catch (e) {
        if (mounted) {
          showErrorSnackBar(
            context,
            context.l10n.deviceShopErrorWithDetails('$e'),
          );
        }
      }
    }
  }
}

class _ProductListItem extends StatelessWidget {
  final ShopProduct product;
  final VoidCallback onEdit;
  final VoidCallback onToggleActive;
  final VoidCallback onDelete;

  const _ProductListItem({
    required this.product,
    required this.onEdit,
    required this.onToggleActive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: product.isActive
          ? Colors.white.withValues(alpha: 0.05)
          : AppTheme.errorRed.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing12),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                child: product.primaryImage != null
                    ? Image.network(
                        product.primaryImage!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _placeholderImage(),
                      )
                    : _placeholderImage(),
              ),
              SizedBox(width: AppTheme.spacing12),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!product.isActive)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.errorRed.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radius4,
                              ),
                            ),
                            child: Text(
                              context.l10n.adminProductsInactiveBadge,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.errorRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (product.isFeatured)
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.warningYellow.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radius4,
                              ),
                            ),
                            child: Text(
                              context.l10n.adminProductsFeaturedBadge,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.warningYellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      '${product.category.displayLabel(context.l10n)} • ${product.sellerName}',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Row(
                      children: [
                        Text(
                          product.formattedPrice(context.l10n),
                          style: TextStyle(
                            color: context.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Icon(
                          Icons.visibility,
                          size: 14,
                          color: context.textTertiary,
                        ),
                        const SizedBox(width: AppTheme.spacing4),
                        Text(
                          '${product.viewCount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textTertiary,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Icon(
                          Icons.shopping_cart,
                          size: 14,
                          color: context.textTertiary,
                        ),
                        const SizedBox(width: AppTheme.spacing4),
                        Text(
                          '${product.salesCount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              AppBarOverflowMenu<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      onEdit();
                      break;
                    case 'toggle':
                      onToggleActive();
                      break;
                    case 'delete':
                      onDelete();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20),
                        SizedBox(width: AppTheme.spacing8),
                        Text(context.l10n.adminProductsEdit),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'toggle',
                    child: Row(
                      children: [
                        Icon(
                          product.isActive
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        Text(
                          product.isActive
                              ? context.l10n.adminProductsDeactivate
                              : context.l10n.adminProductsActivate,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: AppTheme.errorRed),
                        SizedBox(width: AppTheme.spacing8),
                        Text(
                          context.l10n.adminProductsDeleteMenu,
                          style: TextStyle(color: AppTheme.errorRed),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      width: 60,
      height: 60,
      color: SemanticColors.disabled.withValues(alpha: 0.3),
      child: const Icon(Icons.image, color: SemanticColors.disabled),
    );
  }
}

/// Screen for creating/editing a product
class AdminProductEditScreen extends ConsumerStatefulWidget {
  final ShopProduct? product;

  const AdminProductEditScreen({super.key, this.product});

  @override
  ConsumerState<AdminProductEditScreen> createState() =>
      _AdminProductEditScreenState();
}

class _AdminProductEditScreenState extends ConsumerState<AdminProductEditScreen>
    with LifecycleSafeMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _compareAtPriceController = TextEditingController();
  final _purchaseUrlController = TextEditingController();
  final _tagsController = TextEditingController();
  final _chipsetController = TextEditingController();
  final _loraChipController = TextEditingController();
  final _batteryCapacityController = TextEditingController();
  final _weightController = TextEditingController();
  final _dimensionsController = TextEditingController();
  final _stockQuantityController = TextEditingController();
  final _featuredOrderController = TextEditingController();

  bool _isLoading = false;
  bool _isUploadingImage = false;
  List<String> _imageUrls = [];
  DeviceCategory _category = DeviceCategory.node;
  String? _sellerId;
  String? _sellerName;
  List<FrequencyBand> _frequencyBands = [];
  bool _hasGps = false;
  bool _hasWifi = false;
  bool _hasBluetooth = false;
  bool _hasDisplay = false;
  bool _isInStock = true;
  bool _isFeatured = false;
  bool _isActive = true;
  bool _vendorVerified = false;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _loadProduct(widget.product!);
    }
  }

  void _loadProduct(ShopProduct product) {
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _shortDescriptionController.text = product.shortDescription ?? '';
    _priceController.text = product.price.toString();
    _compareAtPriceController.text = product.compareAtPrice?.toString() ?? '';
    _purchaseUrlController.text = product.purchaseUrl ?? '';
    _tagsController.text = product.tags.join(', ');
    _chipsetController.text = product.chipset ?? '';
    _featuredOrderController.text = product.featuredOrder.toString();
    _loraChipController.text = product.loraChip ?? '';
    _batteryCapacityController.text = product.batteryCapacity ?? '';
    _weightController.text = product.weight ?? '';
    _dimensionsController.text = product.dimensions ?? '';
    _stockQuantityController.text = product.stockQuantity.toString();

    _imageUrls = List.from(product.imageUrls);
    _category = product.category;
    _sellerId = product.sellerId;
    _sellerName = product.sellerName;
    _frequencyBands = List.from(product.frequencyBands);
    _hasGps = product.hasGps;
    _hasWifi = product.hasWifi;
    _hasBluetooth = product.hasBluetooth;
    _hasDisplay = product.hasDisplay;
    _isInStock = product.isInStock;
    _isFeatured = product.isFeatured;
    _isActive = product.isActive;
    _vendorVerified = product.vendorVerified;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _shortDescriptionController.dispose();
    _priceController.dispose();
    _compareAtPriceController.dispose();
    _purchaseUrlController.dispose();
    _tagsController.dispose();
    _chipsetController.dispose();
    _loraChipController.dispose();
    _batteryCapacityController.dispose();
    _weightController.dispose();
    _dimensionsController.dispose();
    _stockQuantityController.dispose();
    _featuredOrderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sellersAsync = ref.watch(shopSellersProvider);

    return GlassScaffold(
      title: _isEditing
          ? context.l10n.adminProductsEditTitle
          : context.l10n.adminProductsAddTitle,
      actions: [
        if (_isEditing)
          IconButton(
            icon: const Icon(Icons.delete, color: AppTheme.errorRed),
            onPressed: _confirmDelete,
            tooltip: context.l10n.adminProductsDeleteTooltip,
          ),
      ],
      slivers: [
        SliverToBoxAdapter(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Images Section
                  _buildSectionTitle(context.l10n.adminProductsImagesSection),
                  _buildImageSection(),
                  const SizedBox(height: AppTheme.spacing24),

                  // Basic Info
                  _buildSectionTitle(
                    context.l10n.adminProductsBasicInfoSection,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: context.l10n.adminProductsNameLabel,
                      hintText: context.l10n.adminProductsNameHint,
                    ),
                    validator: (v) => v?.isEmpty == true
                        ? context.l10n.adminProductsRequired
                        : null,
                  ),
                  const SizedBox(height: AppTheme.spacing16),

                  TextFormField(
                    controller: _shortDescriptionController,
                    decoration: InputDecoration(
                      labelText: context.l10n.adminProductsShortDescLabel,
                      hintText: context.l10n.adminProductsShortDescHint,
                      counterText: '',
                    ),
                    maxLength: 150,
                  ),
                  const SizedBox(height: AppTheme.spacing16),

                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: context.l10n.adminProductsFullDescLabel,
                      hintText: context.l10n.adminProductsFullDescHint,
                    ),
                    maxLines: 5,
                    validator: (v) => v?.isEmpty == true
                        ? context.l10n.adminProductsRequired
                        : null,
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // Category & Seller
                  _buildSectionTitle(
                    context.l10n.adminProductsCategorySellerSection,
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: context.l10n.adminProductsCategoryLabel,
                    ),
                    child: DropdownButton<DeviceCategory>(
                      value: _category,
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      items: DeviceCategory.values.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(cat.displayLabel(context.l10n)),
                        );
                      }).toList(),
                      onChanged: (cat) {
                        if (cat != null) setState(() => _category = cat);
                      },
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),

                  sellersAsync.when(
                    data: (sellers) => InputDecorator(
                      decoration: InputDecoration(
                        labelText: context.l10n.adminProductsSellerLabel,
                      ),
                      child: DropdownButton<String>(
                        value: _sellerId,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: Text(context.l10n.adminProductsSelectSeller),
                        items: sellers.map((seller) {
                          return DropdownMenuItem(
                            value: seller.id,
                            child: Text(seller.name),
                          );
                        }).toList(),
                        onChanged: (id) {
                          if (id != null) {
                            final seller = sellers.firstWhere(
                              (s) => s.id == id,
                            );
                            setState(() {
                              _sellerId = id;
                              _sellerName = seller.name;
                            });
                          }
                        },
                      ),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, s) => Text(
                      context.l10n.adminProductsErrorLoadingSellers(
                        e.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // Pricing
                  _buildSectionTitle(context.l10n.adminProductsPricingSection),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: context.l10n.adminProductsPriceLabel,
                            prefixText: '\$ ',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v?.isEmpty == true) {
                              return context.l10n.adminProductsRequired;
                            }
                            if (double.tryParse(v!) == null) {
                              return context.l10n.adminProductsInvalid;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: AppTheme.spacing16),
                      Expanded(
                        child: TextFormField(
                          controller: _compareAtPriceController,
                          decoration: InputDecoration(
                            labelText:
                                context.l10n.adminProductsComparePriceLabel,
                            prefixText: '\$ ',
                            hintText:
                                context.l10n.adminProductsComparePriceHint,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // External URL
                  _buildSectionTitle(
                    context.l10n.adminProductsPurchaseLinkSection,
                  ),
                  TextFormField(
                    controller: _purchaseUrlController,
                    decoration: InputDecoration(
                      labelText: context.l10n.adminProductsPurchaseUrlLabel,
                      hintText: 'https://...',
                      prefixIcon: Icon(Icons.link),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // Technical Specs
                  _buildSectionTitle(
                    context.l10n.adminProductsTechSpecsSection,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _chipsetController,
                          decoration: InputDecoration(
                            labelText: context.l10n.adminProductsChipsetLabel,
                            hintText: context.l10n.adminProductsChipsetHint,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing16),
                      Expanded(
                        child: TextFormField(
                          controller: _loraChipController,
                          decoration: InputDecoration(
                            labelText: context.l10n.adminProductsLoraChipLabel,
                            hintText: context.l10n.adminProductsLoraChipHint,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing16),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _batteryCapacityController,
                          decoration: InputDecoration(
                            labelText: context.l10n.adminProductsBatteryLabel,
                            hintText: context.l10n.adminProductsBatteryHint,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing16),
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          decoration: InputDecoration(
                            labelText: context.l10n.adminProductsWeightLabel,
                            hintText: context.l10n.adminProductsWeightHint,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing16),

                  // Features checkboxes
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: Text(context.l10n.adminProductsGps),
                        selected: _hasGps,
                        onSelected: (v) => setState(() => _hasGps = v),
                        selectedColor: context.accentColor.withValues(
                          alpha: 0.3,
                        ),
                        checkmarkColor: context.accentColor,
                      ),
                      FilterChip(
                        label: Text(context.l10n.adminProductsWifi),
                        selected: _hasWifi,
                        onSelected: (v) => setState(() => _hasWifi = v),
                        selectedColor: context.accentColor.withValues(
                          alpha: 0.3,
                        ),
                        checkmarkColor: context.accentColor,
                      ),
                      FilterChip(
                        label: Text(context.l10n.adminProductsBluetooth),
                        selected: _hasBluetooth,
                        onSelected: (v) => setState(() => _hasBluetooth = v),
                        selectedColor: context.accentColor.withValues(
                          alpha: 0.3,
                        ),
                        checkmarkColor: context.accentColor,
                      ),
                      FilterChip(
                        label: Text(context.l10n.adminProductsDisplay),
                        selected: _hasDisplay,
                        onSelected: (v) => setState(() => _hasDisplay = v),
                        selectedColor: context.accentColor.withValues(
                          alpha: 0.3,
                        ),
                        checkmarkColor: context.accentColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing16),

                  // Frequency Bands
                  _buildSectionTitle(
                    context.l10n.adminProductsFrequencyBandsSection,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: FrequencyBand.values.map((band) {
                      final selected = _frequencyBands.contains(band);
                      return FilterChip(
                        label: Text(band.displayLabel(context.l10n)),
                        selected: selected,
                        onSelected: (v) {
                          setState(() {
                            if (v) {
                              _frequencyBands.add(band);
                            } else {
                              _frequencyBands.remove(band);
                            }
                          });
                        },
                        selectedColor: context.accentColor.withValues(
                          alpha: 0.3,
                        ),
                        checkmarkColor: context.accentColor,
                      );
                    }).toList(),
                  ),
                  SizedBox(height: AppTheme.spacing24),

                  // Physical Specs
                  _buildSectionTitle(
                    context.l10n.adminProductsPhysicalSpecsSection,
                  ),
                  TextFormField(
                    controller: _dimensionsController,
                    decoration: InputDecoration(
                      labelText: context.l10n.adminProductsDimensionsLabel,
                      hintText: context.l10n.adminProductsDimensionsHint,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // Tags
                  _buildSectionTitle(context.l10n.adminProductsTagsSection),
                  TextFormField(
                    controller: _tagsController,
                    decoration: InputDecoration(
                      labelText: context.l10n.adminProductsTagsLabel,
                      hintText: context.l10n.adminProductsTagsHint,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // Stock & Status
                  _buildSectionTitle(context.l10n.adminProductsStockSection),
                  TextFormField(
                    controller: _stockQuantityController,
                    decoration: InputDecoration(
                      labelText: context.l10n.adminProductsStockLabel,
                      hintText: context.l10n.adminProductsStockHint,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppTheme.spacing16),

                  ListTile(
                    title: Text(context.l10n.adminProductsInStock),
                    trailing: ThemedSwitch(
                      value: _isInStock,
                      onChanged: (v) => setState(() => _isInStock = v),
                    ),
                  ),
                  ListTile(
                    title: Text(context.l10n.adminProductsFeatured),
                    subtitle: Text(context.l10n.adminProductsFeaturedSubtitle),
                    trailing: ThemedSwitch(
                      value: _isFeatured,
                      onChanged: (v) => setState(() => _isFeatured = v),
                    ),
                  ),
                  if (_isFeatured)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        controller: _featuredOrderController,
                        decoration: InputDecoration(
                          labelText:
                              context.l10n.adminProductsFeaturedOrderLabel,
                          hintText: context.l10n.adminProductsFeaturedOrderHint,
                          helperText:
                              context.l10n.adminProductsFeaturedOrderHelper,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  const SizedBox(height: AppTheme.spacing8),
                  ListTile(
                    title: Text(context.l10n.adminProductsActive),
                    subtitle: Text(context.l10n.adminProductsActiveSubtitle),
                    trailing: ThemedSwitch(
                      value: _isActive,
                      onChanged: (v) => setState(() => _isActive = v),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // Vendor Verification Section
                  _buildSectionTitle(
                    context.l10n.adminProductsVendorVerificationSection,
                  ),
                  Card(
                    color: _vendorVerified
                        ? AppTheme.successGreen.withValues(alpha: 0.1)
                        : Colors.white.withValues(alpha: 0.05),
                    child: ListTile(
                      title: Text(
                        context.l10n.adminProductsVendorVerifiedTitle,
                      ),
                      subtitle: Text(
                        _vendorVerified
                            ? context.l10n.adminProductsVendorVerifiedSubtitle
                            : context
                                  .l10n
                                  .adminProductsVendorUnverifiedSubtitle,
                      ),
                      leading: Icon(
                        _vendorVerified
                            ? Icons.verified
                            : Icons.verified_outlined,
                        color: _vendorVerified ? AppTheme.successGreen : null,
                      ),
                      trailing: ThemedSwitch(
                        value: _vendorVerified,
                        onChanged: (v) => setState(() => _vendorVerified = v),
                        activeColor: AppTheme.successGreen,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing32),

                  // Save Button
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 50),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.accentColor,
                          foregroundColor: Colors.white,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _isEditing
                                    ? context.l10n.adminProductsSaveChanges
                                    : context.l10n.adminProductsCreate,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing32),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: context.accentColor,
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image grid
        if (_imageUrls.isNotEmpty)
          SizedBox(
            height: 100,
            child: ReorderableListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imageUrls.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final item = _imageUrls.removeAt(oldIndex);
                  _imageUrls.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  key: ValueKey(_imageUrls[index]),
                  padding: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppTheme.radius8),
                        child: Image.network(
                          _imageUrls[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 100,
                                height: 100,
                                color: SemanticColors.disabled,
                                child: const Icon(Icons.broken_image),
                              ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            setState(() => _imageUrls.removeAt(index));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(AppTheme.spacing4),
                            decoration: BoxDecoration(
                              color: AppTheme.errorRed,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      if (index == 0)
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.accentColor,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radius4,
                              ),
                            ),
                            child: Text(
                              context.l10n.adminProductsMainImage,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: AppTheme.spacing12),

        // Add image button
        OutlinedButton.icon(
          onPressed: _isUploadingImage ? null : _pickAndUploadImage,
          icon: _isUploadingImage
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add_photo_alternate),
          label: Text(
            _isUploadingImage
                ? context.l10n.adminProductsUploading
                : context.l10n.adminProductsAddImage,
          ),
        ),
        if (_imageUrls.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              context.l10n.adminProductsImageRequired,
              style: TextStyle(
                color: AppTheme.errorRed.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickAndUploadImage() async {
    final service = ref.read(deviceShopServiceProvider);

    setState(() => _isUploadingImage = true);

    try {
      final image = await service.pickImage();
      if (!mounted) return;
      if (image == null) {
        setState(() => _isUploadingImage = false);
        return;
      }

      final productId =
          widget.product?.id ?? 'new_${DateTime.now().millisecondsSinceEpoch}';
      final url = await service.uploadProductImage(
        productId: productId,
        imageFile: File(image.path),
      );

      if (!mounted) return;
      setState(() {
        _imageUrls.add(url);
        _isUploadingImage = false;
      });
    } catch (e) {
      setState(() => _isUploadingImage = false);
      if (mounted) {
        showErrorSnackBar(
          context,
          context.l10n.deviceShopFailedToUploadImage('$e'),
        );
      }
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imageUrls.isEmpty) {
      showWarningSnackBar(context, context.l10n.adminProductsImageWarning);
      return;
    }
    if (_sellerId == null) {
      showWarningSnackBar(
        context,
        context.l10n.adminProductsSelectSellerWarning,
      );
      return;
    }

    // Capture providers before async gap
    final service = ref.read(deviceShopServiceProvider);
    final user = ref.read(currentUserProvider);
    final l10n = context.l10n;

    safeSetState(() => _isLoading = true);

    try {
      final tags = _tagsController.text
          .split(',')
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty)
          .toList();

      final featuredOrder = _featuredOrderController.text.isEmpty
          ? 999
          : int.tryParse(_featuredOrderController.text) ?? 999;

      final product = ShopProduct(
        id: widget.product?.id ?? '',
        name: _nameController.text,
        description: _descriptionController.text,
        shortDescription: _shortDescriptionController.text.isEmpty
            ? null
            : _shortDescriptionController.text,
        category: _category,
        price: double.parse(_priceController.text),
        compareAtPrice: _compareAtPriceController.text.isEmpty
            ? null
            : double.parse(_compareAtPriceController.text),
        currency: 'USD',
        sellerId: _sellerId!,
        sellerName: _sellerName!,
        imageUrls: _imageUrls,
        frequencyBands: _frequencyBands,
        chipset: _chipsetController.text.isEmpty
            ? null
            : _chipsetController.text,
        loraChip: _loraChipController.text.isEmpty
            ? null
            : _loraChipController.text,
        hasGps: _hasGps,
        hasWifi: _hasWifi,
        hasBluetooth: _hasBluetooth,
        hasDisplay: _hasDisplay,
        batteryCapacity: _batteryCapacityController.text.isEmpty
            ? null
            : _batteryCapacityController.text,
        weight: _weightController.text.isEmpty ? null : _weightController.text,
        dimensions: _dimensionsController.text.isEmpty
            ? null
            : _dimensionsController.text,
        stockQuantity: _stockQuantityController.text.isEmpty
            ? 0
            : int.parse(_stockQuantityController.text),
        purchaseUrl: _purchaseUrlController.text.isEmpty
            ? null
            : _purchaseUrlController.text,
        tags: tags,
        isFeatured: _isFeatured,
        featuredOrder: featuredOrder,
        isInStock: _isInStock,
        isActive: _isActive,
        vendorVerified: _vendorVerified,
        approvedAt: _vendorVerified && widget.product?.approvedAt == null
            ? DateTime.now()
            : widget.product?.approvedAt,
        viewCount: widget.product?.viewCount ?? 0,
        salesCount: widget.product?.salesCount ?? 0,
        favoriteCount: widget.product?.favoriteCount ?? 0,
        rating: widget.product?.rating ?? 0,
        reviewCount: widget.product?.reviewCount ?? 0,
        createdAt: widget.product?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (_isEditing) {
        await service.updateFullProduct(product, adminId: user?.uid);
      } else {
        await service.createProduct(product, adminId: user?.uid);
      }

      if (!mounted) return;
      ref.invalidate(adminAllProductsProvider);

      safeNavigatorPop();
      safeShowSnackBar(
        _isEditing ? l10n.adminProductsUpdated : l10n.adminProductsCreated,
      );
    } catch (e) {
      safeSetState(() => _isLoading = false);
      if (mounted) {
        showErrorSnackBar(
          context,
          context.l10n.deviceShopErrorWithDetails('$e'),
        );
      }
    }
  }

  Future<void> _confirmDelete() async {
    if (widget.product == null) return;

    // Capture providers before async gap
    final service = ref.read(deviceShopServiceProvider);
    final l10n = context.l10n;

    final confirmed = await AppBottomSheet.showConfirm(
      context: context,
      title: l10n.adminProductsDeleteConfirmTitle,
      message: l10n.adminProductsDeleteConfirmMessage,
      confirmLabel: l10n.adminProductsDelete,
      isDestructive: true,
    );

    if (confirmed == true && mounted) {
      try {
        await service.deleteProductPermanently(widget.product!.id);
        if (!mounted) return;
        ref.invalidate(adminAllProductsProvider);
        safeNavigatorPop();
        safeShowSnackBar(l10n.adminProductsDeletedSuccess);
      } catch (e) {
        if (mounted) {
          showErrorSnackBar(
            context,
            context.l10n.deviceShopErrorWithDetails('$e'),
          );
        }
      }
    }
  }
}
