import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum UserRole { customer, provider, admin }

extension UserRoleDisplay on UserRole {
  String get label {
    switch (this) {
      case UserRole.customer:
        return 'Customer';
      case UserRole.provider:
        return 'Provider';
      case UserRole.admin:
        return 'Admin';
    }
  }

  String get intro {
    switch (this) {
      case UserRole.customer:
        return 'I need a service';
      case UserRole.provider:
        return 'I want to work';
      case UserRole.admin:
        return 'I manage services';
    }
  }

  String get tagline {
    switch (this) {
      case UserRole.customer:
        return 'Book trusted, verified help for your home.';
      case UserRole.provider:
        return 'Offer your skills and grow your business.';
      case UserRole.admin:
        return 'Oversee operations and ensure quality.';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.customer:
        return LucideIcons.user;
      case UserRole.provider:
        return LucideIcons.briefcase;
      case UserRole.admin:
        return LucideIcons.shield;
    }
  }
}
