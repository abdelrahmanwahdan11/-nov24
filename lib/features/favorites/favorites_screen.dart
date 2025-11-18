import 'package:flutter/material.dart';
import '../../core/controllers/cart_controller.dart';
import '../../core/controllers/favorites_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/product_card.dart';
import '../../core/routing/app_router.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoritesController controller;
  final CartController cartController;
  const FavoritesScreen({super.key, required this.controller, required this.cartController});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return StreamBuilder<List<dynamic>>(
      stream: controller.favoritesStream,
      builder: (_, snapshot) {
        final list = snapshot.data ?? [];
        if (list.isEmpty) {
          return Center(child: Text(loc.t('empty_favorites')));
        }
        return RefreshIndicator(
          onRefresh: () async {},
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: list.length,
            itemBuilder: (_, index) {
              final product = list[index];
              return ProductCard(
                product: product,
                onTap: () => Navigator.pushNamed(context, AppRouter.productDetails, arguments: product),
                onFavorite: () => controller.toggleFavorite(product),
                onAdd: () => cartController.addToCart(product, 1),
              );
            },
          ),
        );
      },
    );
  }
}
