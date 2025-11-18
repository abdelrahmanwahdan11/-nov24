import 'package:flutter/material.dart';
import '../../core/controllers/product_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context).productController;
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('compare'))),
      body: StreamBuilder(
        stream: controller.comparisonSelectionStream,
        builder: (_, snapshot) {
          final items = snapshot.data ?? [];
          if (items.length < 2) {
            return Center(child: Text(loc.t('no_items_compare')));
          }
          return ListView(
            scrollDirection: Axis.horizontal,
            children: items.map((p) {
              return SizedBox(
                width: 220,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Image.network(p.imageUrl, height: 120),
                        Text(p.nameEn, maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text('\$${p.price}'),
                        Text(p.size),
                        Text(p.skinType),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Go to product'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
