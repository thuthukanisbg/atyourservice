import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Placeholder body for a bottom-nav tab that isn't built yet. Used so the
/// navigation shell for each role is complete and feels real now, while
/// being upfront that the tab's content is a future milestone.
class ComingSoonTab extends StatelessWidget {
  const ComingSoonTab({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text('$title is coming soon', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'This tab lands in an upcoming milestone.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
