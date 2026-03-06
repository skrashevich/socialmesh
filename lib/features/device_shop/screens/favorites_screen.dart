// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../../core/widgets/auto_scroll_text.dart';
import '../../../providers/auth_providers.dart';
import '../models/shop_models.dart';
import '../providers/device_shop_providers.dart';
import 'product_detail_screen.dart';

/// Screen showing user's favorited products
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return GlassScaffold(
        titleWidget: AutoScrollText(
          context.l10n.shopFavoritesTitle,
          style: TextStyle(color: context.textPrimary),
          maxLines: 1,
          velocity: 30.0,
          fadeWidth: 20.0,
        ),
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    color: context.textTertiary,
                    size: 64,
                  ),
                  SizedBox(height: AppTheme.spacing16),
                  Text(
                    context.l10n.shopFavoritesSignIn,
                    style: TextStyle(color: context.textPrimary, fontSize: 18),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    context.l10n.shopFavoritesSignInSubtitle,
                    style: TextStyle(color: context.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    final favoritesAsync = ref.watch(userFavoritesProvider(user.uid));

    return GlassScaffold(
      titleWidget: AutoScrollText(
        context.l10n.shopFavoritesTitle,
        style: TextStyle(color: context.textPrimary),
        maxLines: 1,
        velocity: 30.0,
        fadeWidth: 20.0,
      ),
      slivers: [
        favoritesAsync.when(
          loading: () => SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: AppTheme.errorRed, size: 48),
                  const SizedBox(height: AppTheme.spacing16),
                  Text(
                    context.l10n.shopFavoritesErrorLoading,
                    style: TextStyle(color: context.textPrimary),
                  ),
                  TextButton(
                    onPressed: () =>
                        ref.invalidate(userFavoritesProvider(user.uid)),
                    child: Text(context.l10n.shopFavoritesRetry),
                  ),
                ],
              ),
            ),
          ),
          data: (favorites) {
            if (favorites.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        color: context.textTertiary,
                        size: 64,
                      ),
                      SizedBox(height: AppTheme.spacing16),
                      Text(
                        context.l10n.shopFavoritesEmpty,
                        style: TextStyle(
                          color: context.textPrimary,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      Text(
                        context.l10n.shopFavoritesEmptySubtitle,
                        style: TextStyle(color: context.textSecondary),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return _FavoriteProductCard(
                    favorite: favorites[index],
                    userId: user.uid,
                  );
                }, childCount: favorites.length),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FavoriteProductCard extends ConsumerWidget {
  final ProductFavorite favorite;
  final String userId;

  const _FavoriteProductCard({required this.favorite, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(
      singleProductFutureProvider(favorite.productId),
    );

    return productAsync.when(
      loading: () => _buildLoadingCard(context),
      error: (error, stack) => _buildErrorCard(context, ref),
      data: (product) {
        if (product == null) {
          return _buildRemovedCard(context, ref);
        }
        return _buildProductCard(context, ref, product);
      },
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return Card(
      color: context.card,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(AppTheme.spacing12),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, WidgetRef ref) {
    return Card(
      color: context.card,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: ListTile(
        leading: Icon(Icons.error_outline, color: AppTheme.errorRed),
        title: Text(
          context.l10n.shopFavoritesUnableToLoad,
          style: TextStyle(color: context.textPrimary),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: context.textTertiary),
          onPressed: () => _removeFavorite(ref),
        ),
      ),
    );
  }

  Widget _buildRemovedCard(BuildContext context, WidgetRef ref) {
    return Card(
      color: context.card,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: ListTile(
        leading: Icon(Icons.inventory_2_outlined, color: context.textTertiary),
        title: Text(
          context.l10n.shopFavoritesProductRemoved,
          style: TextStyle(color: context.textSecondary),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: context.textTertiary),
          onPressed: () => _removeFavorite(ref),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    WidgetRef ref,
    ShopProduct product,
  ) {
    return Dismissible(
      key: Key(favorite.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.errorRed,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _removeFavorite(ref),
      child: Card(
        color: context.card,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(productId: product.id),
            ),
          ),
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing12),
            child: Row(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  child: product.primaryImage != null
                      ? Image.network(
                          product.primaryImage!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _imagePlaceholder(context),
                        )
                      : _imagePlaceholder(context),
                ),
                SizedBox(width: AppTheme.spacing12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          color: context.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppTheme.spacing4),
                      Text(
                        product.sellerName,
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: AppTheme.spacing8),
                      Row(
                        children: [
                          Text(
                            product.formattedPrice(context.l10n),
                            style: TextStyle(
                              color: context.accentColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (product.isOnSale) ...[
                            const SizedBox(width: AppTheme.spacing6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.errorRed,
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radius4,
                                ),
                              ),
                              child: Text(
                                '-${product.discountPercent}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          const Spacer(),
                          // Stock status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: product.isInStock
                                  ? AppTheme.successGreen.withValues(alpha: 0.2)
                                  : AppTheme.errorRed.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radius4,
                              ),
                            ),
                            child: Text(
                              product.isInStock
                                  ? context.l10n.shopFavoritesInStock
                                  : context.l10n.shopFavoritesOutOfStock,
                              style: TextStyle(
                                color: product.isInStock
                                    ? AppTheme.successGreen
                                    : AppTheme.errorRed,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Reviews
                      if (product.reviewCount > 0) ...[
                        const SizedBox(height: AppTheme.spacing6),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppTheme.warningYellow,
                              size: 14,
                            ),
                            const SizedBox(width: AppTheme.spacing4),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: TextStyle(
                                color: context.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              ' (${product.reviewCount} review${product.reviewCount == 1 ? '' : 's'})',
                              style: TextStyle(
                                color: context.textTertiary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Remove button
                IconButton(
                  icon: const Icon(Icons.favorite, color: AppTheme.errorRed),
                  onPressed: () => _removeFavorite(ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imagePlaceholder(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      color: context.background,
      child: Icon(Icons.router, color: context.textTertiary, size: 32),
    );
  }

  void _removeFavorite(WidgetRef ref) {
    toggleFavoriteQueued(ref, userId: userId, productId: favorite.productId);
  }
}
