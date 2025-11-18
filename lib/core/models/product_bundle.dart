class ProductBundle {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final List<String> productIds;
  final List<String> benefits;

  const ProductBundle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.productIds,
    required this.benefits,
  });
}
