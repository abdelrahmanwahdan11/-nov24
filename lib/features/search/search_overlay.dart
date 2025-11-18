import 'package:flutter/material.dart';
import '../../core/controllers/search_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/product_card.dart';
import '../../main.dart';

class SearchOverlay extends StatefulWidget {
  const SearchOverlay({super.key});

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  final queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final search = AppScope.of(context).searchController;
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('search'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: queryController,
              decoration: InputDecoration(
                hintText: loc.t('search_products'),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => search.search(queryController.text),
                ),
              ),
              onChanged: search.search,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: search.resultsStream,
              builder: (_, snapshot) {
                final results = snapshot.data ?? [];
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: results.length,
                  itemBuilder: (_, index) {
                    final product = results[index];
                    return ProductCard(
                      product: product,
                      onTap: () => Navigator.pop(context, product),
                      onFavorite: () => AppScope.of(context).favoritesController.toggleFavorite(product),
                      onAdd: () => AppScope.of(context).cartController.addToCart(product, 1),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
