import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/models/product.dart';
import '../../core/widgets/rating_stars.dart';
import '../../core/widgets/quantity_selector.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nameEn),
        actions: [
          IconButton(
            icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => scope.favoritesController.toggleFavorite(product),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: product.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(product.imageUrl, height: 240, fit: BoxFit.cover),
            ).animate().scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.nameEn, style: Theme.of(context).textTheme.titleMedium),
              Text('\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            ],
          ),
          const SizedBox(height: 8),
          RatingStars(rating: product.rating),
          const SizedBox(height: 8),
          Text(product.descriptionLongEn),
          const SizedBox(height: 12),
          QuantitySelector(
            value: qty,
            onIncrement: () => setState(() => qty++),
            onDecrement: () => setState(() => qty = (qty - 1).clamp(1, 99)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(loc.t('ai_info')),
                        content: Text(loc.t('ai_dialog')),
                        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                      ),
                    );
                  },
                  child: Text(loc.t('ai_info')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => scope.cartController.addToCart(product, qty),
                  child: Text(loc.t('add_to_cart')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
