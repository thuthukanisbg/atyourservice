import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/currency.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_tile.dart';
import '../../core/widgets/status_chip.dart';
import '../../models/job_request.dart';
import '../../models/provider_application.dart';
import 'provider_mock_data.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({super.key});

  static const routeName = '/provider';

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  late List<JobRequest> _jobs = buildProviderJobRequests(DateTime.now());

  void _respond(JobRequest job, JobStatus status) {
    setState(() {
      _jobs = [
        for (final existing in _jobs)
          if (existing.id == job.id) existing.copyWith(status: status) else existing,
      ];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == JobStatus.accepted
              ? 'Accepted ${job.serviceTitle} for ${job.customerName}.'
              : 'Declined ${job.serviceTitle}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final requested = _jobs.where((j) => j.status == JobStatus.requested).toList();
    final upcoming = _jobs.where((j) => j.status == JobStatus.accepted || j.status == JobStatus.inProgress).toList();
    final completed = _jobs.where((j) => j.status == JobStatus.completed).toList();
    final weekEarnings = completed.fold<double>(0, (sum, job) => sum + job.price);

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
                    Text('Welcome back, Sipho 👋', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 2),
                    Text('Here\'s what\'s happening today.', style: Theme.of(context).textTheme.bodyLarge),
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
          if (providerApplicationStatus == ProviderApplicationStatus.approved)
            StatusChip(label: 'Verified provider', color: AppColors.success)
          else
            AppCard(
              child: Row(
                children: [
                  Icon(Icons.hourglass_top_rounded, color: providerApplicationStatus.color),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your application is ${providerApplicationStatus.label.toLowerCase()}. '
                      'We will notify you once an admin reviews it.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  label: 'New requests',
                  value: '${requested.length}',
                  icon: Icons.notifications_active_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatTile(
                  label: 'Upcoming jobs',
                  value: '${upcoming.length}',
                  icon: Icons.event_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatTile(
                  label: 'This week',
                  value: formatRand(weekEarnings),
                  icon: Icons.payments_outlined,
                ),
              ),
            ],
          ),
          if (requested.isNotEmpty) ...[
            const SizedBox(height: 28),
            const SectionHeader(title: 'New requests'),
            const SizedBox(height: 12),
            for (final job in requested) ...[
              _JobCard(
                job: job,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: () => _respond(job, JobStatus.declined),
                      child: const Text('Decline'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: AppTheme.amberAction,
                      onPressed: () => _respond(job, JobStatus.accepted),
                      child: const Text('Accept'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ],
          if (upcoming.isNotEmpty) ...[
            const SizedBox(height: 16),
            const SectionHeader(title: 'Upcoming jobs'),
            const SizedBox(height: 12),
            for (final job in upcoming) ...[
              _JobCard(job: job, trailing: StatusChip(label: job.status.label, color: job.status.color)),
              const SizedBox(height: 12),
            ],
          ],
          if (completed.isNotEmpty) ...[
            const SizedBox(height: 16),
            const SectionHeader(title: 'Completed'),
            const SizedBox(height: 12),
            for (final job in completed) ...[
              _JobCard(job: job, trailing: StatusChip(label: job.status.label, color: job.status.color)),
              const SizedBox(height: 12),
            ],
          ],
        ],
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.job, required this.trailing});

  final JobRequest job;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.tokens;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.serviceTitle, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(job.customerName, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              Text(formatRand(job.price), style: theme.textTheme.titleMedium?.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.place_outlined, size: 16, color: tokens.mut),
              const SizedBox(width: 4),
              Expanded(child: Text(job.address, style: theme.textTheme.bodyMedium)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.schedule_outlined, size: 16, color: tokens.mut),
              const SizedBox(width: 4),
              Text(_formatSchedule(job.scheduledFor), style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: trailing),
        ],
      ),
    );
  }
}

String _formatSchedule(DateTime date) {
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
  final period = date.hour >= 12 ? 'PM' : 'AM';
  final minute = date.minute.toString().padLeft(2, '0');
  return '${weekdays[date.weekday - 1]}, $hour:$minute $period';
}
