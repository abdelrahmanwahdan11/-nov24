import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../core/controllers/cart_controller.dart';
import '../../core/controllers/favorites_controller.dart';
import '../../core/controllers/product_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/app_skeleton.dart';
import '../../core/widgets/product_card.dart';
import '../../core/widgets/search_bar.dart';
import '../../core/routing/app_router.dart';
import '../../core/data/mock_products.dart';

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
  late RangeValues _priceRange;
  late double _minPrice;
  late double _maxPrice;
  final List<String> _selectedCategories = [];
  late final List<String> _allCategories;

  @override
  void initState() {
    super.initState();
    final prices = mockProducts.map((e) => e.price).toList();
    _minPrice = prices.reduce(math.min);
    _maxPrice = prices.reduce(math.max);
    _priceRange = RangeValues(_minPrice, _maxPrice);
    _allCategories = mockProducts.map((e) => e.category).toSet().toList();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 200) {
      widget.controller.loadNextCatalogPage();
    }
  }

  void _openFilters() {
    final loc = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        RangeValues tempRange = _priceRange;
        final tempCategories = List<String>.from(_selectedCategories);
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(loc.t('filters'), style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _priceRange = RangeValues(_minPrice, _maxPrice);
                          _selectedCategories.clear();
                        });
                        widget.controller.applyFilters(
                          minPrice: _minPrice,
                          maxPrice: _maxPrice,
                          categories: const [],
                        );
                        Navigator.pop(context);
                      },
                      child: Text(loc.t('clear')),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(loc.t('price_range')),
                RangeSlider(
                  values: tempRange,
                  min: _minPrice,
                  max: _maxPrice,
                  divisions: 10,
                  labels: RangeLabels(
                    tempRange.start.toStringAsFixed(0),
                    tempRange.end.toStringAsFixed(0),
                  ),
                  onChanged: (value) {
                    setModalState(() => tempRange = value);
                  },
                ),
                const SizedBox(height: 12),
                Text(loc.t('categories')),
                Wrap(
                  spacing: 8,
                  children: _allCategories
                      .map(
                        (cat) => FilterChip(
                          label: Text(cat),
                          selected: tempCategories.contains(cat),
                          onSelected: (v) {
                            setModalState(() {
                              if (v) {
                                tempCategories.add(cat);
                              } else {
                                tempCategories.remove(cat);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _priceRange = tempRange;
                        _selectedCategories
                          ..clear()
                          ..addAll(tempCategories);
                      });
                      widget.controller.applyFilters(
                        minPrice: _priceRange.start,
                        maxPrice: _priceRange.end,
                        categories: _selectedCategories,
                      );
                      Navigator.pop(context);
                    },
                    child: Text(loc.t('apply')),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          );
        });
      },
    );
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
      onRefresh: () async {
        await widget.controller.refreshCatalog();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppSearchBar(
                    onTap: () => Navigator.pushNamed(context, AppRouter.search),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: _openFilters,
                )
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRouter.bundles),
                icon: const Icon(Icons.card_giftcard_outlined),
                label: Text(loc.t('curated_sets')),
              ),
            ),
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
                  if (list.isEmpty) {
                    return Center(child: Text(loc.t('empty_catalog')));
                  }
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 900
                          ? 4
                          : constraints.maxWidth > 600
                              ? 3
                              : 2;
                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: 0.72,
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
                            ),
                          ),
                          StreamBuilder<bool>(
                            stream: widget.controller.isPaginatingStream,
                            initialData: false,
                            builder: (context, snap) {
                              if (snap.data == true) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          )
                        ],
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
