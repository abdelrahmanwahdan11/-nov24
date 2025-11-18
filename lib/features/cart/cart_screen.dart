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
        if (items.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 64),
                  const SizedBox(height: 12),
                  Text(loc.t('empty_cart'),
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(loc.t('pull_refresh')),
                ],
              ),
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
                    return Dismissible(
                      key: ValueKey(item.product.id),
                      background: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => controller.removeFromCart(item.product),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.product.imageUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(item.product.nameEn),
                        subtitle: Text(
                            '${loc.t('currency')} ${item.total.toStringAsFixed(2)}'),
                        trailing: QuantitySelector(
                          value: item.quantity,
                          onIncrement: () => controller.updateQuantity(
                              item.product, item.quantity + 1),
                          onDecrement: () => controller.updateQuantity(
                              item.product, (item.quantity - 1).clamp(1, 99)),
                        ),
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
                        children: [
                          Text(loc.t('subtotal')),
                          Text(
                              '${loc.t('currency')} ${summary.subtotal.toStringAsFixed(2)}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(loc.t('delivery_fee')),
                          Text(
                              '${loc.t('currency')} ${summary.delivery.toStringAsFixed(2)}'),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(loc.t('total'),
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(
                            '${loc.t('currency')} ${summary.total.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRouter.checkout),
                        child: Text(loc.t('checkout_title')),
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
