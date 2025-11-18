import 'package:flutter/material.dart';
import '../../core/data/mock_orders.dart';
import '../../core/widgets/order_tile.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order history')),
      body: ListView.builder(
        itemCount: mockOrders.length,
        itemBuilder: (_, index) => OrderTile(order: mockOrders[index]),
      ),
    );
  }
}
