import 'package:flutter/material.dart';
import '../../core/controllers/cart_controller.dart';
import '../../core/controllers/favorites_controller.dart';
import '../../core/controllers/product_controller.dart';
import '../../core/data/mock_products.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/product_card.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/app_skeleton.dart';
import '../../core/widgets/product_3d_card.dart';
import '../../core/widgets/search_bar.dart';
import '../../core/routing/app_router.dart';

class HomeScreen extends StatefulWidget {
  final ProductController controller;
  final FavoritesController favoritesController;
  final CartController cartController;
  const HomeScreen({super.key, required this.controller, required this.favoritesController, required this.cartController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: widget.controller.refreshHomeData,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(loc.t('home')),
            actions: [IconButton(onPressed: () => Navigator.pushNamed(context, AppRouter.compare), icon: const Icon(Icons.balance))],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSearchBar(onTap: () => Navigator.pushNamed(context, AppRouter.compare)),
                  const SizedBox(height: 12),
                  SectionHeader(title: loc.t('best_products')),
                  SizedBox(
                    height: 220,
                    child: StreamBuilder<List<dynamic>>(
                      stream: widget.controller.homeBestProductsStream,
                      builder: (_, snapshot) {
                        final data = snapshot.data;
                        if (data == null) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (_, __) => const AppSkeleton(width: 160, height: 200),
                          );
                        }
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (_, index) {
                            final product = data[index];
                            return SizedBox(
                              width: 180,
                              child: Product3DCard(product: product),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SectionHeader(title: loc.t('recommended')),
                  StreamBuilder<List<dynamic>>(
                    stream: widget.controller.homeRecommendedStream,
                    builder: (_, snapshot) {
                      final list = snapshot.data;
                      if (list == null) {
                        return Column(
                          children: const [
                            AppSkeleton(height: 140),
                            SizedBox(height: 12),
                            AppSkeleton(height: 140),
                          ],
                        );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
