import 'package:flutter/material.dart';

class ServiceCategory {
  const ServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.tint,
    required this.price,
  });

  final String id;
  final String name;
  final IconData icon;

  /// Icon/text color for this category's badge. Background is derived as a
  /// low-alpha tint of this color (per the design handoff's per-category
  /// `bg`/`fg` pairs).
  final Color tint;

  /// "From R___" caption shown on the category card.
  final String price;
}
