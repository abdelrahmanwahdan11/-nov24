import 'package:flutter/material.dart';
import '../../core/controllers/cart_controller.dart';
import '../../core/controllers/favorites_controller.dart';
import '../../core/controllers/product_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/app_skeleton.dart';
import '../../core/widgets/product_card.dart';
import '../../core/widgets/search_bar.dart';
import '../../core/routing/app_router.dart';

class CatalogScreen extends StatefulWidget {
  final ProductController controller;
  final FavoritesController favoritesController;
  final CartController cartController;
  const CatalogScreen({super.key, required this.controller, required this.favoritesController, required this.cartController});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 200) {
      widget.controller.loadCatalogPage(0 + 1);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: widget.controller.refreshCatalog,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppSearchBar(onTap: () => Navigator.pushNamed(context, AppRouter.compare)),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: widget.controller.catalogProductsStream,
                builder: (_, snapshot) {
                  final list = snapshot.data;
                  if (list == null) {
                    return GridView.builder(
                      controller: _scrollController,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: 4,
                      itemBuilder: (_, __) => const AppSkeleton(height: 220),
                    );
                  }
                  return GridView.builder(
                    controller: _scrollController,
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
                        onFavorite: () => widget.favoritesController.toggleFavorite(product),
                        onAdd: () => widget.cartController.addToCart(product, 1),
                        onCompare: () => widget.controller.toggleCompareSelection(product),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
