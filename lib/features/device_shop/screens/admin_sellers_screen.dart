// SPDX-License-Identifier: GPL-3.0-or-later
// lint-allow: haptic-feedback — onTap delegates to parent callback
// lint-allow: keyboard-dismissal — edit screen uses GestureDetector for unfocus below
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/safety/lifecycle_mixin.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/animations.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../../core/widgets/search_filter_header.dart';
import '../../../core/widgets/app_bar_overflow_menu.dart';
import '../../../providers/auth_providers.dart';
import '../../../utils/snackbar.dart';
import '../models/shop_models.dart';
import '../providers/admin_shop_providers.dart';
import '../providers/device_shop_providers.dart';

/// Admin screen for managing sellers
class AdminSellersScreen extends ConsumerStatefulWidget {
  const AdminSellersScreen({super.key});

  @override
  ConsumerState<AdminSellersScreen> createState() => _AdminSellersScreenState();
}

class _AdminSellersScreenState extends ConsumerState<AdminSellersScreen>
    with LifecycleSafeMixin<AdminSellersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showInactive = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sellersAsync = ref.watch(adminAllSellersProvider);

    return GlassScaffold(
      resizeToAvoidBottomInset: false,
      title: context.l10n.adminSellersTitle,
      actions: [
        IconButton(
          icon: Icon(
            _showInactive ? Icons.visibility : Icons.visibility_off,
            color: _showInactive ? context.accentColor : null,
          ),
          onPressed: () => setState(() => _showInactive = !_showInactive),
          tooltip: _showInactive
              ? context.l10n.adminSellersHideInactive
              : context.l10n.adminSellersShowInactive,
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _navigateToEdit(null),
          tooltip: context.l10n.adminSellersAddTooltip,
        ),
      ],
      slivers: [
        // Pinned search header
        SliverPersistentHeader(
          pinned: true,
          delegate: SearchFilterHeaderDelegate(
            searchController: _searchController,
            searchQuery: _searchQuery,
            onSearchChanged: (value) => setState(() => _searchQuery = value),
            hintText: context.l10n.adminSellersSearchHint,
            textScaler: MediaQuery.textScalerOf(context),
          ),
        ),

        // Sellers List
        sellersAsync.when(
          data: (sellers) {
            var filtered = sellers.where((s) {
              if (!_showInactive && !s.isActive) return false;
              if (_searchQuery.isNotEmpty) {
                final query = _searchQuery.toLowerCase();
                return s.name.toLowerCase().contains(query) ||
                    (s.description?.toLowerCase().contains(query) ?? false);
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
                        Icons.store_outlined,
                        size: 64,
                        color: context.textTertiary,
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      Text(context.l10n.adminSellersNotFound),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final seller = filtered[index];
                  return _SellerListItem(
                    seller: seller,
                    onEdit: () => _navigateToEdit(seller),
                    onToggleActive: () => _toggleActive(seller),
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
    );
  }

  void _navigateToEdit(ShopSeller? seller) {
    if (seller != null) {
      ref.read(sellerFormProvider.notifier).loadSeller(seller);
    } else {
      ref.read(sellerFormProvider.notifier).reset();
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AdminSellerEditScreen(seller: seller)),
    );
  }

  Future<void> _toggleActive(ShopSeller seller) async {
    final service = ref.read(deviceShopServiceProvider);
    final user = ref.read(currentUserProvider);

    try {
      await service.updateSeller(seller.id, {
        'isActive': !seller.isActive,
      }, adminId: user?.uid);
      if (!mounted) return;
      ref.invalidate(adminAllSellersProvider);
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

class _SellerListItem extends StatelessWidget {
  final ShopSeller seller;
  final VoidCallback onEdit;
  final VoidCallback onToggleActive;

  const _SellerListItem({
    required this.seller,
    required this.onEdit,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: seller.isActive
          ? Colors.white.withValues(alpha: 0.05)
          : AppTheme.errorRed.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Row(
            children: [
              // Seller Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                child: seller.logoUrl != null
                    ? Image.network(
                        seller.logoUrl!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _placeholderLogo(),
                      )
                    : _placeholderLogo(),
              ),
              const SizedBox(width: AppTheme.spacing16),

              // Seller Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      seller.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    // Status badges
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        if (!seller.isActive)
                          _buildBadge(
                            context.l10n.adminSellersInactiveBadge,
                            AppTheme.errorRed,
                          ),
                        if (seller.isOfficialPartner)
                          _buildBadge(
                            context.l10n.adminSellersPartnerBadge,
                            AppTheme.successGreen,
                          ),
                        if (seller.isVerified)
                          _buildBadge(
                            context.l10n.adminSellersVerifiedBadge,
                            AccentColors.blue,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    if (seller.description != null)
                      Text(
                        seller.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: context.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: AppTheme.spacing8),
                    Row(
                      children: [
                        _buildStat(
                          context,
                          Icons.inventory_2,
                          '${seller.productCount}',
                        ),
                        const SizedBox(width: AppTheme.spacing16),
                        _buildStat(
                          context,
                          Icons.shopping_cart,
                          '${seller.salesCount}',
                        ),
                        const SizedBox(width: AppTheme.spacing16),
                        _buildStat(
                          context,
                          Icons.star,
                          seller.rating.toStringAsFixed(1),
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
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        const Icon(Icons.edit, size: 20),
                        const SizedBox(width: AppTheme.spacing8),
                        Text(context.l10n.adminSellersEdit),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'toggle',
                    child: Row(
                      children: [
                        Icon(
                          seller.isActive
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        Text(
                          seller.isActive
                              ? context.l10n.adminSellersDeactivate
                              : context.l10n.adminSellersActivate,
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

  Widget _placeholderLogo() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: SemanticColors.disabled.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: const Icon(Icons.store, color: SemanticColors.disabled),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppTheme.radius4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: context.textTertiary),
        const SizedBox(width: AppTheme.spacing4),
        Text(
          value,
          style: context.bodySmallStyle?.copyWith(color: context.textTertiary),
        ),
      ],
    );
  }
}

/// Screen for creating/editing a seller
class AdminSellerEditScreen extends ConsumerStatefulWidget {
  final ShopSeller? seller;

  const AdminSellerEditScreen({super.key, this.seller});

  @override
  ConsumerState<AdminSellerEditScreen> createState() =>
      _AdminSellerEditScreenState();
}

class _AdminSellerEditScreenState extends ConsumerState<AdminSellerEditScreen>
    with LifecycleSafeMixin<AdminSellerEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _websiteUrlController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _countriesController = TextEditingController();

  // Discount code controllers
  final _discountCodeController = TextEditingController();
  final _discountLabelController = TextEditingController();
  final _discountTermsController = TextEditingController();

  bool _isLoading = false;
  bool _isUploadingLogo = false;
  String? _logoUrl;
  bool _isVerified = false;
  bool _isOfficialPartner = false;
  bool _isActive = true;
  DateTime? _discountCodeExpiry;

  bool get _isEditing => widget.seller != null;

  @override
  void initState() {
    super.initState();
    if (widget.seller != null) {
      _loadSeller(widget.seller!);
    }
  }

  void _loadSeller(ShopSeller seller) {
    _nameController.text = seller.name;
    _descriptionController.text = seller.description ?? '';
    _websiteUrlController.text = seller.websiteUrl ?? '';
    _contactEmailController.text = seller.contactEmail ?? '';
    _countriesController.text = seller.countries.join(', ');
    _logoUrl = seller.logoUrl;
    _isVerified = seller.isVerified;
    _isOfficialPartner = seller.isOfficialPartner;
    _isActive = seller.isActive;

    // Discount code fields
    _discountCodeController.text = seller.discountCode ?? '';
    _discountLabelController.text = seller.discountCodeLabel ?? '';
    _discountTermsController.text = seller.discountCodeTerms ?? '';
    _discountCodeExpiry = seller.discountCodeExpiry;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _websiteUrlController.dispose();
    _contactEmailController.dispose();
    _countriesController.dispose();
    _discountCodeController.dispose();
    _discountLabelController.dispose();
    _discountTermsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GlassScaffold(
        title: _isEditing
            ? context.l10n.adminSellersEditTitle
            : context.l10n.adminSellersAddTitle,
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete, color: AppTheme.errorRed),
              onPressed: _confirmDelete,
              tooltip: context.l10n.adminSellersDeleteTooltip,
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
                    // Logo Section
                    _buildSectionTitle(context.l10n.adminSellersLogoSection),
                    _buildLogoSection(),
                    const SizedBox(height: AppTheme.spacing24),

                    // Basic Info
                    _buildSectionTitle(
                      context.l10n.adminSellersBasicInfoSection,
                    ),
                    TextFormField(
                      maxLength: 100,
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: context.l10n.adminSellersNameLabel,
                        hintText: context.l10n.adminSellersNameHint,
                        counterText: '',
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: AppTheme.spacing16),

                    TextFormField(
                      maxLength: 500,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: context.l10n.adminSellersDescriptionLabel,
                        hintText: context.l10n.adminSellersDescriptionHint,
                        counterText: '',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppTheme.spacing24),

                    // Contact Info
                    _buildSectionTitle(
                      context.l10n.adminSellersContactInfoSection,
                    ),
                    TextFormField(
                      maxLength: 100,
                      controller: _websiteUrlController,
                      decoration: InputDecoration(
                        labelText: context.l10n.adminSellersWebsiteLabel,
                        hintText: 'https://...', // lint-allow: hardcoded-string
                        prefixIcon: const Icon(Icons.link),
                        counterText: '',
                      ),
                      keyboardType: TextInputType.url,
                      validator: (v) => v?.isEmpty == true
                          ? context.l10n.deviceShopFieldRequired
                          : null,
                    ),
                    const SizedBox(height: AppTheme.spacing16),

                    TextFormField(
                      maxLength: 100,
                      controller: _contactEmailController,
                      decoration: InputDecoration(
                        labelText: context.l10n.adminSellersEmailLabel,
                        hintText: context.l10n.adminSellersEmailHint,
                        prefixIcon: const Icon(Icons.email),
                        counterText: '',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppTheme.spacing24),

                    // Shipping Countries
                    _buildSectionTitle(
                      context.l10n.adminSellersShippingSection,
                    ),
                    TextFormField(
                      maxLength: 100,
                      controller: _countriesController,
                      decoration: InputDecoration(
                        labelText: context.l10n.adminSellersCountriesLabel,
                        hintText: context.l10n.adminSellersCountriesHint,
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing24),

                    // Discount Code Section
                    _buildSectionTitle(
                      context.l10n.adminSellersDiscountSection,
                    ),
                    _buildDiscountCodeSection(),
                    const SizedBox(height: AppTheme.spacing24),

                    // Status Toggles
                    _buildSectionTitle(context.l10n.adminSellersStatusSection),
                    ListTile(
                      title: Text(context.l10n.adminSellersVerifiedToggle),
                      subtitle: Text(context.l10n.adminSellersVerifiedSubtitle),
                      trailing: ThemedSwitch(
                        value: _isVerified,
                        onChanged: (v) => setState(() => _isVerified = v),
                      ),
                    ),
                    ListTile(
                      title: Text(context.l10n.adminSellersOfficialPartner),
                      subtitle: Text(
                        context.l10n.adminSellersOfficialPartnerSubtitle,
                      ),
                      trailing: ThemedSwitch(
                        value: _isOfficialPartner,
                        onChanged: (v) =>
                            setState(() => _isOfficialPartner = v),
                      ),
                    ),
                    ListTile(
                      title: Text(context.l10n.adminSellersActive),
                      subtitle: Text(context.l10n.adminSellersActiveSubtitle),
                      trailing: ThemedSwitch(
                        value: _isActive,
                        onChanged: (v) => setState(() => _isActive = v),
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
                                      ? context.l10n.adminSellersSaveChanges
                                      : context.l10n.adminSellersCreate,
                                ),
                        ),
                      ),
                    ),

                    // Delete Section for existing sellers
                    if (_isEditing) ...[
                      const SizedBox(height: AppTheme.spacing24),
                      const Divider(),
                      const SizedBox(height: AppTheme.spacing16),
                      _buildSectionTitle(context.l10n.adminSellersDangerZone),
                      Card(
                        color: AppTheme.errorRed.withValues(alpha: 0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(AppTheme.spacing16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.warning,
                                    color: AppTheme.errorRed,
                                  ),
                                  const SizedBox(width: AppTheme.spacing8),
                                  Text(
                                    context.l10n.adminSellersDeleteTitle,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.errorRed,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppTheme.spacing8),
                              Text(
                                context.l10n.adminSellersDeleteDescription,
                                style: TextStyle(
                                  color: context.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: AppTheme.spacing16),
                              OutlinedButton(
                                onPressed: _confirmDelete,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.errorRed,
                                  side: const BorderSide(
                                    color: AppTheme.errorRed,
                                  ),
                                ),
                                child: Text(
                                  context.l10n.adminSellersDeletePermanently,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: AppTheme.spacing32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildDiscountCodeSection() {
    final hasDiscount = _discountCodeController.text.isNotEmpty;
    final isExpired =
        _discountCodeExpiry != null &&
        DateTime.now().isAfter(_discountCodeExpiry!);

    return Card(
      color: hasDiscount
          ? (isExpired
                ? AccentColors.orange.withValues(alpha: 0.1)
                : AppTheme.successGreen.withValues(alpha: 0.1))
          : Colors.white.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasDiscount && isExpired)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AccentColors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radius4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.warning,
                      color: AccentColors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: AppTheme.spacing4),
                    Text(
                      context.l10n.adminSellersDiscountExpired,
                      style: const TextStyle(
                        color: AccentColors.orange,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            TextFormField(
              maxLength: 100,
              controller: _discountCodeController,
              decoration: InputDecoration(
                labelText: context.l10n.adminSellersDiscountCodeLabel,
                hintText: context.l10n.adminSellersDiscountCodeHint,
                prefixIcon: const Icon(Icons.local_offer),
                counterText: '',
              ),
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: AppTheme.spacing16),
            TextFormField(
              maxLength: 100,
              controller: _discountLabelController,
              decoration: InputDecoration(
                labelText: context.l10n.adminSellersDiscountDisplayLabel,
                hintText: context.l10n.adminSellersDiscountDisplayHint,
                counterText: '',
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            InkWell(
              onTap: _selectExpiryDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: context.l10n.adminSellersDiscountExpiryLabel,
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _discountCodeExpiry != null
                          ? '${_discountCodeExpiry!.day}/${_discountCodeExpiry!.month}/${_discountCodeExpiry!.year}'
                          : context.l10n.adminSellersDiscountNoExpiry,
                      style: TextStyle(
                        color: _discountCodeExpiry != null
                            ? context.textPrimary
                            : context.textSecondary,
                      ),
                    ),
                    if (_discountCodeExpiry != null)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () =>
                            setState(() => _discountCodeExpiry = null),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            TextFormField(
              maxLength: 500,
              controller: _discountTermsController,
              decoration: InputDecoration(
                labelText: context.l10n.adminSellersDiscountTermsLabel,
                hintText: context.l10n.adminSellersDiscountTermsHint,
                counterText: '',
              ),
              maxLines: 2,
            ),
            if (hasDiscount) ...[
              const SizedBox(height: AppTheme.spacing16),
              TextButton.icon(
                onPressed: _clearDiscountCode,
                icon: const Icon(Icons.clear, size: 18),
                label: Text(context.l10n.adminSellersClearDiscount),
                style: TextButton.styleFrom(foregroundColor: AppTheme.errorRed),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _selectExpiryDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _discountCodeExpiry ?? now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 2)),
    );
    if (!mounted) return;
    if (picked != null) {
      safeSetState(() => _discountCodeExpiry = picked);
    }
  }

  void _clearDiscountCode() {
    setState(() {
      _discountCodeController.clear();
      _discountLabelController.clear();
      _discountTermsController.clear();
      _discountCodeExpiry = null;
    });
  }

  Widget _buildLogoSection() {
    return Row(
      children: [
        // Logo preview
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          child: _logoUrl != null
              ? Image.network(
                  _logoUrl!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _placeholderLogo(),
                )
              : _placeholderLogo(),
        ),
        const SizedBox(width: AppTheme.spacing16),

        // Upload button
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              onPressed: _isUploadingLogo ? null : _pickAndUploadLogo,
              icon: _isUploadingLogo
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.upload),
              label: Text(
                _isUploadingLogo
                    ? context.l10n.adminSellersUploading
                    : context.l10n.adminSellersUploadLogo,
              ),
            ),
            if (_logoUrl != null)
              TextButton(
                onPressed: () => setState(() => _logoUrl = null),
                child: Text(
                  context.l10n.adminSellersRemoveLogo,
                  style: const TextStyle(color: AppTheme.errorRed),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _placeholderLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: SemanticColors.disabled.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: const Icon(Icons.store, color: SemanticColors.disabled, size: 32),
    );
  }

  Future<void> _pickAndUploadLogo() async {
    final service = ref.read(deviceShopServiceProvider);

    safeSetState(() => _isUploadingLogo = true);

    try {
      final image = await service.pickImage();
      if (!mounted) return;
      if (image == null) {
        safeSetState(() => _isUploadingLogo = false);
        return;
      }

      final sellerId =
          widget.seller?.id ?? 'new_${DateTime.now().millisecondsSinceEpoch}';
      final url = await service.uploadSellerLogo(
        sellerId: sellerId,
        imageFile: File(image.path),
      );

      if (!mounted) return;
      safeSetState(() {
        _logoUrl = url;
        _isUploadingLogo = false;
      });
    } catch (e) {
      safeSetState(() => _isUploadingLogo = false);
      if (mounted) {
        showErrorSnackBar(
          context,
          context.l10n.deviceShopFailedToUploadLogo('$e'),
        );
      }
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    // Capture providers before any await
    final service = ref.read(deviceShopServiceProvider);
    final user = ref.read(currentUserProvider);
    final navigator = Navigator.of(context);
    final l10n = context.l10n;

    safeSetState(() => _isLoading = true);

    try {
      final countries = _countriesController.text
          .split(',')
          .map((c) => c.trim().toUpperCase())
          .where((c) => c.isNotEmpty)
          .toList();

      final seller = ShopSeller(
        id: widget.seller?.id ?? '',
        name: _nameController.text,
        description: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        logoUrl: _logoUrl,
        websiteUrl: _websiteUrlController.text,
        contactEmail: _contactEmailController.text.isEmpty
            ? null
            : _contactEmailController.text,
        isVerified: _isVerified,
        isOfficialPartner: _isOfficialPartner,
        isActive: _isActive,
        rating: widget.seller?.rating ?? 0,
        reviewCount: widget.seller?.reviewCount ?? 0,
        productCount: widget.seller?.productCount ?? 0,
        salesCount: widget.seller?.salesCount ?? 0,
        joinedAt: widget.seller?.joinedAt ?? DateTime.now(),
        countries: countries,
        // Discount code fields
        discountCode: _discountCodeController.text.isEmpty
            ? null
            : _discountCodeController.text.toUpperCase(),
        discountCodeLabel: _discountLabelController.text.isEmpty
            ? null
            : _discountLabelController.text,
        discountCodeExpiry: _discountCodeExpiry,
        discountCodeTerms: _discountTermsController.text.isEmpty
            ? null
            : _discountTermsController.text,
      );

      if (_isEditing) {
        await service.updateFullSeller(seller, adminId: user?.uid);
      } else {
        await service.createSeller(seller, adminId: user?.uid);
      }

      if (!mounted) return;
      ref.invalidate(adminAllSellersProvider);
      ref.invalidate(shopSellersProvider);

      navigator.pop();
      showSuccessSnackBar(
        context,
        _isEditing ? l10n.adminSellersUpdated : l10n.adminSellersCreated,
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
    if (widget.seller == null) return;

    // Capture providers before any await
    final service = ref.read(deviceShopServiceProvider);
    final navigator = Navigator.of(context);
    final l10n = context.l10n;

    final productCount = widget.seller!.productCount;
    final confirmed = await AppBottomSheet.show<bool>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.adminSellersDeleteDialogTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(l10n.adminSellersDeleteDialogMessage(widget.seller!.name)),
          if (productCount > 0) ...[
            const SizedBox(height: AppTheme.spacing12),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AccentColors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: AccentColors.orange),
                  const SizedBox(width: AppTheme.spacing8),
                  Expanded(
                    child: Text(
                      l10n.adminSellersDeleteProductWarning(productCount),
                      style: const TextStyle(color: AccentColors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppTheme.spacing12),
          Text(
            l10n.adminSellersDeleteUndoWarning,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppTheme.spacing24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: SemanticColors.divider),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                    ),
                  ),
                  child: Text(l10n.adminSellersCancel),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppTheme.errorRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                    ),
                  ),
                  child: Text(l10n.adminSellersDeleteConfirm),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (confirmed == true) {
      try {
        await service.deleteSellerPermanently(widget.seller!.id);
        if (!mounted) return;
        ref.invalidate(adminAllSellersProvider);
        ref.invalidate(shopSellersProvider);
        navigator.pop();
        showSuccessSnackBar(context, l10n.adminSellersDeleted);
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
