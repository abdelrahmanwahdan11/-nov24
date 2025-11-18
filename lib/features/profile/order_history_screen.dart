import 'package:flutter/material.dart';
import '../../core/data/mock_orders.dart';
import '../../core/widgets/order_tile.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/routing/app_router.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('orders'))),
      body: ListView.builder(
        itemCount: mockOrders.length,
        itemBuilder: (_, index) => OrderTile(
          order: mockOrders[index],
          onTap: () => Navigator.pushNamed(
            context,
            AppRouter.orderDetails,
            arguments: mockOrders[index],
          ),
        ),
      ),
    );
  }
}
