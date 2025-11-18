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
      title: Text('Order #${order.id}'),
      subtitle: Text('${order.status} • ${order.date.toLocal().toString().split(' ').first}'),
      trailing: Text('${loc.t('currency')} ${order.total.toStringAsFixed(2)}'),
    );
  }
}
