import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

enum BookingStatus { upcoming, inProgress, completed, cancelled }

extension BookingStatusDisplay on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.inProgress:
        return 'In progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case BookingStatus.upcoming:
        return AppColors.primary;
      case BookingStatus.inProgress:
        return AppColors.accent;
      case BookingStatus.completed:
        return AppColors.success;
      case BookingStatus.cancelled:
        return AppColors.danger;
    }
  }
}

class Booking {
  const Booking({
    required this.id,
    required this.serviceTitle,
    required this.providerName,
    required this.scheduledFor,
    required this.status,
    required this.price,
  });

  final String id;
  final String serviceTitle;
  final String providerName;
  final DateTime scheduledFor;
  final BookingStatus status;
  final double price;
}
