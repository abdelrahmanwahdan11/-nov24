class Coupon {
  final String code;
  final String description;
  final int discountPercent;
  final DateTime expiresOn;
  final bool isApplied;

  const Coupon({
    required this.code,
    required this.description,
    required this.discountPercent,
    required this.expiresOn,
    this.isApplied = false,
  });

  Coupon copyWith({bool? isApplied}) {
    return Coupon(
      code: code,
      description: description,
      discountPercent: discountPercent,
      expiresOn: expiresOn,
      isApplied: isApplied ?? this.isApplied,
    );
  }
}
