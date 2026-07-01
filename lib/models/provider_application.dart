import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

enum ProviderApplicationStatus { pending, approved, rejected }

extension ProviderApplicationStatusDisplay on ProviderApplicationStatus {
  String get label {
    switch (this) {
      case ProviderApplicationStatus.pending:
        return 'Pending review';
      case ProviderApplicationStatus.approved:
        return 'Approved';
      case ProviderApplicationStatus.rejected:
        return 'Rejected';
    }
  }

  Color get color {
    switch (this) {
      case ProviderApplicationStatus.pending:
        return AppColors.accent;
      case ProviderApplicationStatus.approved:
        return AppColors.success;
      case ProviderApplicationStatus.rejected:
        return AppColors.danger;
    }
  }
}

class ProviderApplication {
  const ProviderApplication({
    required this.id,
    required this.providerName,
    required this.categoryName,
    required this.submittedOn,
    required this.status,
  });

  final String id;
  final String providerName;
  final String categoryName;
  final DateTime submittedOn;
  final ProviderApplicationStatus status;

  ProviderApplication copyWith({ProviderApplicationStatus? status}) {
    return ProviderApplication(
      id: id,
      providerName: providerName,
      categoryName: categoryName,
      submittedOn: submittedOn,
      status: status ?? this.status,
    );
  }
}
