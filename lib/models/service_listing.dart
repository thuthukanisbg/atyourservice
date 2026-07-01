class ServiceListing {
  const ServiceListing({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.providerName,
    required this.rating,
    required this.reviewCount,
    required this.priceFrom,
    required this.durationLabel,
  });

  final String id;
  final String categoryId;
  final String title;

  /// Null when the listing is fulfilled by "verified pros" generally
  /// rather than one named provider (e.g. the marketplace's own
  /// recommended listings).
  final String? providerName;
  final double rating;
  final int reviewCount;
  final double priceFrom;
  final String durationLabel;
}
