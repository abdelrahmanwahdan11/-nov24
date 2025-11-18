import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/product.dart';
import '../localization/app_localizations.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final VoidCallback onAdd;
  final VoidCallback? onCompare;

  const ProductCard({super.key, required this.product, required this.onTap, required this.onFavorite, required this.onAdd, this.onCompare});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: product.id,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(22),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                      ).animate().scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)).fadeIn(),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: Icon(product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: onFavorite,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.localizedName(loc.locale),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loc.t('add_to_cart')),
                  IconButton(
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    onPressed: onAdd,
                  ),
                ],
              ),
              if (onCompare != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: onCompare, child: Text(loc.t('compare'))),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
