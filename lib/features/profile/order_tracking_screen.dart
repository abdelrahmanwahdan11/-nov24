import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/order.dart';
import '../../main.dart';

class OrderTrackingScreen extends StatelessWidget {
  final Order order;
  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    final events = order.tracking;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('track_order'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text('${loc.t('carrier')}: ${order.carrier}'),
              subtitle: Text('${loc.t('tracking_code')}: ${order.trackingCode}'),
              trailing: Chip(label: Text(order.status)),
            ),
          ),
          const SizedBox(height: 12),
          Text(loc.t('order_timeline'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (events.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(loc.t('no_tracking')),
            )
          else
            ...List.generate(events.length, (index) {
              final event = events[index];
              final isLast = index == events.length - 1;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        event.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: event.isDone
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).disabledColor,
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 32,
                          color: Theme.of(context).dividerColor,
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(event.title,
                                    style: Theme.of(context).textTheme.titleSmall),
                                Text(event.timestamp,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Theme.of(context).hintColor)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(event.detail, style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          const SizedBox(height: 12),
          if (order.canReorder)
            ElevatedButton.icon(
              onPressed: () {
                for (final item in order.items) {
                  scope.cartController.addToCart(item.product, item.quantity);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(loc.t('reorder_added'))),
                );
              },
              icon: const Icon(Icons.restart_alt),
              label: Text(loc.t('reorder')),
            ),
        ],
      ),
    );
  }
}
