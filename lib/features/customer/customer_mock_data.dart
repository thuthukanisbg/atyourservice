import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../models/service_category.dart';
import '../../models/service_listing.dart';

const customerCategories = [
  ServiceCategory(id: 'cleaning', name: 'Cleaning', icon: LucideIcons.sparkles, tint: AppColors.primary, price: 'R600'),
  ServiceCategory(id: 'plumbing', name: 'Plumbing', icon: LucideIcons.wrench, tint: AppColors.accent, price: 'R500'),
  ServiceCategory(id: 'electrical', name: 'Electrical', icon: LucideIcons.zap, tint: AppColors.success, price: 'R600'),
  ServiceCategory(id: 'painting', name: 'Painting', icon: LucideIcons.paintbrush2, tint: AppColors.purple, price: 'R550'),
];

const customerRecommendedListing = ServiceListing(
  id: 'svc-deep-cleaning',
  categoryId: 'cleaning',
  title: 'Deep House Cleaning',
  providerName: null,
  rating: 4.8,
  reviewCount: 534,
  priceFrom: 600,
  durationLabel: '3-4 hrs',
);
