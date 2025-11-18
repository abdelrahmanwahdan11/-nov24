import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('${loc.t('order')} #${order.id}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text('${loc.t('status')}: ${order.status}'),
              subtitle: Text('${loc.t('delivery')}: ${order.deliveryEstimate}'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: Text(loc.t('address')),
              subtitle: Text(order.addressSummary),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: Text(loc.t('payment_method')),
              subtitle: Text(order.paymentMethod),
            ),
          ),
          const SizedBox(height: 12),
          Text(loc.t('items'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...order.items.map((item) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.product.imageUrl),
                ),
                title: Text(item.product.nameEn),
                subtitle: Text('x${item.quantity} • ${item.product.size}'),
                trailing: Text('${loc.t('currency')} ${item.total.toStringAsFixed(2)}'),
              )),
          const Divider(height: 32),
          ListTile(
            title: Text(loc.t('subtotal')),
            trailing: Text('${loc.t('currency')} ${order.subtotal.toStringAsFixed(2)}'),
          ),
          ListTile(
            title: Text(loc.t('delivery')),
            trailing: Text('${loc.t('currency')} ${order.deliveryFee.toStringAsFixed(2)}'),
          ),
          ListTile(
            title: Text(loc.t('total')),
            trailing: Text('${loc.t('currency')} ${order.total.toStringAsFixed(2)}'),
          ),
        ],
      ),
    );
  }
}
