import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/widgets/coming_soon_tab.dart';
import '../../core/widgets/role_nav_shell.dart';
import 'provider_home_screen.dart';

class ProviderShell extends StatelessWidget {
  const ProviderShell({super.key});

  static const routeName = '/provider';

  @override
  Widget build(BuildContext context) {
    return const RoleNavShell(
      tabs: [
        NavTab(
          icon: LucideIcons.briefcase,
          selectedIcon: LucideIcons.briefcase,
          label: 'Jobs',
          body: ProviderHomeScreen(),
        ),
        NavTab(
          icon: LucideIcons.calendar,
          selectedIcon: LucideIcons.calendar,
          label: 'Schedule',
          body: ComingSoonTab(title: 'Schedule', icon: LucideIcons.calendar),
        ),
        NavTab(
          icon: LucideIcons.wallet,
          selectedIcon: LucideIcons.wallet,
          label: 'Earnings',
          body: ComingSoonTab(title: 'Earnings', icon: LucideIcons.wallet),
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
