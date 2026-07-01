import '../../models/job_request.dart';
import '../../models/provider_application.dart';

const providerApplicationStatus = ProviderApplicationStatus.approved;

List<JobRequest> buildProviderJobRequests(DateTime now) {
  return [
    JobRequest(
      id: 'job-1',
      customerName: 'Naledi P.',
      serviceTitle: 'Deep home cleaning',
      address: '14 Kloof Street, Gardens',
      scheduledFor: now.add(const Duration(hours: 5)),
      price: 450,
      status: JobStatus.requested,
    ),
    JobRequest(
      id: 'job-2',
      customerName: 'Marco D.',
      serviceTitle: 'Office cleaning',
      address: '88 Long Street, CBD',
      scheduledFor: now.add(const Duration(days: 1, hours: 2)),
      price: 780,
      status: JobStatus.accepted,
    ),
    JobRequest(
      id: 'job-3',
      customerName: 'Aisha K.',
      serviceTitle: 'Move-out cleaning',
      address: '3 Buitenkant Street, CBD',
      scheduledFor: now.subtract(const Duration(days: 1)),
      price: 600,
      status: JobStatus.completed,
    ),
  ];
}
