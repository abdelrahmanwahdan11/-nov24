import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Order #${order.id}'),
      subtitle: Text('${order.status} • ${order.date.toLocal().toString().split(' ').first}'),
      trailing: Text('\$${order.total.toStringAsFixed(2)}'),
    );
  }
}
