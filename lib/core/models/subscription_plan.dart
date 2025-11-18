class SubscriptionPlan {
  final String id;
  final String title;
  final String productName;
  final String imageUrl;
  final String frequency;
  final double price;
  final DateTime nextDelivery;
  final bool paused;

  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.productName,
    required this.imageUrl,
    required this.frequency,
    required this.price,
    required this.nextDelivery,
    this.paused = false,
  });

  SubscriptionPlan copyWith({
    String? frequency,
    DateTime? nextDelivery,
    bool? paused,
  }) {
    return SubscriptionPlan(
      id: id,
      title: title,
      productName: productName,
      imageUrl: imageUrl,
      frequency: frequency ?? this.frequency,
      price: price,
      nextDelivery: nextDelivery ?? this.nextDelivery,
      paused: paused ?? this.paused,
    );
  }
}
