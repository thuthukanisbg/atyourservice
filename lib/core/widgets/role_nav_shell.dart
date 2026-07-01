import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NavTab {
  const NavTab({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.body,
    this.showBadge = false,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final Widget body;
  final bool showBadge;
}

/// Persistent bottom-nav shell shared by all three roles. Each role passes
/// its own [NavTab]s — only the first tab needs to be a real screen.
class RoleNavShell extends StatefulWidget {
  const RoleNavShell({super.key, required this.tabs});

  final List<NavTab> tabs;

  @override
  State<RoleNavShell> createState() => _RoleNavShellState();
}

class _RoleNavShellState extends State<RoleNavShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [for (final tab in widget.tabs) tab.body],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: [
          for (final tab in widget.tabs)
            NavigationDestination(
              icon: _badged(Icon(tab.icon), tab.showBadge),
              selectedIcon: _badged(Icon(tab.selectedIcon), tab.showBadge),
              label: tab.label,
            ),
        ],
      ),
    );
  }

  Widget _badged(Widget icon, bool show) {
    if (!show) return icon;
    return Badge(backgroundColor: AppColors.danger, child: icon);
  }
}
