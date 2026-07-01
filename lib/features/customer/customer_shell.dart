import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/widgets/coming_soon_tab.dart';
import '../../core/widgets/role_nav_shell.dart';
import 'customer_home_screen.dart';

class CustomerShell extends StatelessWidget {
  const CustomerShell({super.key});

  static const routeName = '/customer';

  @override
  Widget build(BuildContext context) {
    return const RoleNavShell(
      tabs: [
        NavTab(
          icon: LucideIcons.home,
          selectedIcon: LucideIcons.home,
          label: 'Home',
          body: CustomerHomeScreen(),
        ),
        NavTab(
          icon: LucideIcons.calendarCheck,
          selectedIcon: LucideIcons.calendarCheck,
          label: 'Bookings',
          body: ComingSoonTab(title: 'Bookings', icon: LucideIcons.calendarCheck),
        ),
        NavTab(
          icon: LucideIcons.messageCircle,
          selectedIcon: LucideIcons.messageCircle,
          label: 'Messages',
          body: ComingSoonTab(title: 'Messages', icon: LucideIcons.messageCircle),
          showBadge: true,
        ),
        NavTab(
          icon: LucideIcons.user,
          selectedIcon: LucideIcons.user,
          label: 'Profile',
          body: ComingSoonTab(title: 'Profile', icon: LucideIcons.user),
        ),
      ],
    );
  }
}
