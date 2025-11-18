import 'package:flutter/material.dart';
import '../../core/data/mock_bundles.dart';
import '../../core/data/mock_products.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/product.dart';
import '../../core/widgets/app_button.dart';
import '../../main.dart';

class BundlesScreen extends StatelessWidget {
  const BundlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('bundles'))),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: mockBundles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          final bundle = mockBundles[index];
          final products = _mapProducts(bundle.productIds);
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Ink.image(
                    image: NetworkImage(bundle.imageUrl),
                    fit: BoxFit.cover,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(12),
                      child: Chip(
                        label: Text('${loc.t('currency')} ${bundle.price.toStringAsFixed(0)}'),
                        backgroundColor:
                            Theme.of(context).colorScheme.surface.withOpacity(0.85),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bundle.title, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(bundle.subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Theme.of(context).hintColor)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: bundle.benefits
                            .map((b) => Chip(label: Text(b)))
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      Text(loc.t('bundle_includes'),
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 4),
                      ...products.map(
                        (p) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: CircleAvatar(backgroundImage: NetworkImage(p.imageUrl)),
                          title: Text(p.nameEn),
                          subtitle: Text('${loc.t('currency')} ${p.price.toStringAsFixed(2)}'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppButton(
                        text: loc.t('add_bundle'),
                        onPressed: () {
                          for (final product in products) {
                            scope.cartController.addToCart(product, 1);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(loc.t('bundle_added'))),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Product> _mapProducts(List<String> ids) {
    return ids
        .map((id) => mockProducts.firstWhere((element) => element.id == id))
        .toList();
  }
}
