import 'package:flutter/material.dart';
import '../../core/controllers/cart_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/quantity_selector.dart';
import '../../core/widgets/app_skeleton.dart';
import '../../core/routing/app_router.dart';

class CartScreen extends StatelessWidget {
  final CartController controller;
  const CartScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return StreamBuilder(
      stream: controller.cartItemsStream,
      builder: (_, snapshot) {
        final items = snapshot.data;
        if (items == null) {
          return ListView.builder(
            itemCount: 3,
            itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.all(12.0),
              child: AppSkeleton(height: 80),
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.network(item.product.imageUrl, width: 56, height: 56, fit: BoxFit.cover),
                      title: Text(item.product.nameEn),
                      subtitle: Text('\$${item.total.toStringAsFixed(2)}'),
                      trailing: QuantitySelector(
                        value: item.quantity,
                        onIncrement: () => controller.updateQuantity(item.product, item.quantity + 1),
                        onDecrement: () => controller.updateQuantity(item.product, (item.quantity - 1).clamp(1, 99)),
                      ),
                    );
                  },
                ),
              ),
            ),
            StreamBuilder(
              stream: controller.cartSummaryStream,
              builder: (_, summarySnap) {
                final summary = summarySnap.data;
                if (summary == null) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Total'), Text('\$${summary.total.toStringAsFixed(2)}')],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, AppRouter.compare),
                        child: Text(loc.t('checkout')),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
