import '../../models/provider_application.dart';

List<ProviderApplication> buildAdminProviderApplications(DateTime now) {
  return [
    ProviderApplication(
      id: 'app-1',
      providerName: 'Lindiwe Cleaning Co.',
      categoryName: 'Cleaning',
      submittedOn: now.subtract(const Duration(days: 1)),
      status: ProviderApplicationStatus.pending,
    ),
    ProviderApplication(
      id: 'app-2',
      providerName: 'Pieter Electrical Services',
      categoryName: 'Electrical',
      submittedOn: now.subtract(const Duration(days: 2)),
      status: ProviderApplicationStatus.pending,
    ),
    ProviderApplication(
      id: 'app-3',
      providerName: 'GreenThumb Gardens',
      categoryName: 'Gardening',
      submittedOn: now.subtract(const Duration(hours: 6)),
      status: ProviderApplicationStatus.pending,
    ),
    ProviderApplication(
      id: 'app-4',
      providerName: 'FixIt Appliances',
      categoryName: 'Appliance repair',
      submittedOn: now.subtract(const Duration(days: 5)),
      status: ProviderApplicationStatus.approved,
    ),
  ];
}

const adminBookingsThisMonth = 184;
const adminRevenueThisMonth = 96450.0;
