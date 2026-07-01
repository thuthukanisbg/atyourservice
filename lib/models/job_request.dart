import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

enum JobStatus { requested, accepted, inProgress, completed, declined }

extension JobStatusDisplay on JobStatus {
  String get label {
    switch (this) {
      case JobStatus.requested:
        return 'New request';
      case JobStatus.accepted:
        return 'Accepted';
      case JobStatus.inProgress:
        return 'In progress';
      case JobStatus.completed:
        return 'Completed';
      case JobStatus.declined:
        return 'Declined';
    }
  }

  Color get color {
    switch (this) {
      case JobStatus.requested:
        return AppColors.primary;
      case JobStatus.accepted:
        return AppColors.accent;
      case JobStatus.inProgress:
        return AppColors.accent;
      case JobStatus.completed:
        return AppColors.success;
      case JobStatus.declined:
        return AppColors.danger;
    }
  }
}

class JobRequest {
  const JobRequest({
    required this.id,
    required this.customerName,
    required this.serviceTitle,
    required this.address,
    required this.scheduledFor,
    required this.price,
    required this.status,
  });

  final String id;
  final String customerName;
  final String serviceTitle;
  final String address;
  final DateTime scheduledFor;
  final double price;
  final JobStatus status;

  JobRequest copyWith({JobStatus? status}) {
    return JobRequest(
      id: id,
      customerName: customerName,
      serviceTitle: serviceTitle,
      address: address,
      scheduledFor: scheduledFor,
      price: price,
      status: status ?? this.status,
    );
  }
}
