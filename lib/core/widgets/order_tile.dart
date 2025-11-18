import 'package:flutter/material.dart';
import '../models/order.dart';
import '../localization/app_localizations.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;
  const OrderTile({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ListTile(
      onTap: onTap,
      isThreeLine: true,
      title: Text('Order #${order.id}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${order.date.toLocal().toString().split(' ').first} • ${order.deliveryEstimate}'),
          const SizedBox(height: 4),
          Chip(label: Text(order.status)),
        ],
      ),
      trailing: Text('${loc.t('currency')} ${order.total.toStringAsFixed(2)}'),
    );
  }
}
