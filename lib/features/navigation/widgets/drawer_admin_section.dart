// SPDX-License-Identifier: GPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/safety/lifecycle_mixin.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/admin_pin_dialog.dart';
import '../../../services/haptic_service.dart';
import '../../admin/screens/admin_screen.dart';
import '../../device_shop/providers/admin_shop_providers.dart';
import '../main_shell.dart';
import 'drawer_menu_tile.dart';

/// Admin section in the drawer — visible to shop admins with PIN protection.
///
/// Uses [LifecycleSafeMixin] because the PIN dialog is async (await) and
/// we must guard against the widget being disposed while the dialog is open.
class DrawerAdminSection extends ConsumerStatefulWidget {
  final void Function(Widget screen) onNavigate;

  const DrawerAdminSection({super.key, required this.onNavigate});

  @override
  ConsumerState<DrawerAdminSection> createState() => _DrawerAdminSectionState();
}

class _DrawerAdminSectionState extends ConsumerState<DrawerAdminSection>
    with LifecycleSafeMixin<DrawerAdminSection> {
  Future<void> _handleAdminTap() async {
    ref.haptics.tabChange();

    // Show PIN verification dialog
    final verified = await AdminPinDialog.show(context);
    if (!canUpdateUI) return;

    if (verified) {
      widget.onNavigate(const AdminScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdminAsync = ref.watch(isShopAdminProvider);

    return isAdminAsync.when(
      data: (isAdmin) {
        if (!isAdmin) return const SizedBox.shrink();

        final theme = Theme.of(context);

        // Combined badge count for admin notifications
        final badgeCount = ref.watch(adminNotificationCountProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section header
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.admin_panel_settings,
                          size: 14,
                          color: AccentColors.orange.withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: AppTheme.spacing6),
                        Text(
                          'ADMIN',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: AccentColors.orange.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Single Admin entry with PIN protection
                  DrawerMenuTile(
                    icon: Icons.shield_outlined,
                    label: 'Admin Dashboard',
                    isSelected: false,
                    iconColor: AccentColors.orange,
                    badgeCount: badgeCount > 0 ? badgeCount : null,
                    onTap: _handleAdminTap,
                  ),
                ],
              ),
            ),

            // Divider after admin section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(
                color: theme.dividerColor.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.1 : 0.2,
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
