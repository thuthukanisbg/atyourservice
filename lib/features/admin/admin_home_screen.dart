import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/currency.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_tile.dart';
import '../../core/widgets/status_chip.dart';
import '../../models/provider_application.dart';
import 'admin_mock_data.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  static const routeName = '/admin';

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late List<ProviderApplication> _applications = buildAdminProviderApplications(DateTime.now());

  void _review(ProviderApplication application, ProviderApplicationStatus status) {
    setState(() {
      _applications = [
        for (final existing in _applications)
          if (existing.id == application.id) existing.copyWith(status: status) else existing,
      ];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == ProviderApplicationStatus.approved
              ? '${application.providerName} approved.'
              : '${application.providerName} rejected.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final pending = _applications.where((a) => a.status == ProviderApplicationStatus.pending).toList();
    final reviewed = _applications.where((a) => a.status != ProviderApplicationStatus.pending).toList();
    final activeProviders = _applications.where((a) => a.status == ProviderApplicationStatus.approved).length;

    return Scaffold(
      body: SafeArea(
        child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Marketplace overview', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 2),
                    Text('This month\'s performance.', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: tokens.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: tokens.line),
                ),
                child: const Icon(Icons.notifications_none_rounded, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 18),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              StatTile(
                label: 'Pending approvals',
                value: '${pending.length}',
                icon: Icons.fact_check_outlined,
              ),
              StatTile(
                label: 'Active providers',
                value: '$activeProviders',
                icon: Icons.groups_outlined,
              ),
              StatTile(
                label: 'Bookings this month',
                value: '$adminBookingsThisMonth',
                icon: Icons.calendar_month_outlined,
              ),
              StatTile(
                label: 'Revenue this month',
                value: formatRand(adminRevenueThisMonth),
                icon: Icons.trending_up_rounded,
              ),
            ],
          ),
          const SizedBox(height: 28),
          SectionHeader(title: 'Provider approvals (${pending.length})'),
          const SizedBox(height: 12),
          if (pending.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text('No applications waiting for review.', style: Theme.of(context).textTheme.bodyMedium),
              ),
            )
          else
            for (final application in pending) ...[
              _ApplicationCard(
                application: application,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.danger,
                        side: const BorderSide(color: AppColors.danger),
                      ),
                      onPressed: () => _review(application, ProviderApplicationStatus.rejected),
                      child: const Text('Reject'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => _review(application, ProviderApplicationStatus.approved),
                      child: const Text('Approve'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          if (reviewed.isNotEmpty) ...[
            const SizedBox(height: 16),
            const SectionHeader(title: 'Recently reviewed'),
            const SizedBox(height: 12),
            for (final application in reviewed) ...[
              _ApplicationCard(
                application: application,
                trailing: StatusChip(label: application.status.label, color: application.status.color),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ],
        ),
      ),
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({required this.application, required this.trailing});

  final ProviderApplication application;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.storefront_outlined, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(application.providerName, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      '${application.categoryName} • submitted ${_daysAgo(application.submittedOn)}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: trailing),
        ],
      ),
    );
  }
}

String _daysAgo(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inDays >= 1) return '${diff.inDays}d ago';
  if (diff.inHours >= 1) return '${diff.inHours}h ago';
  return 'just now';
}
