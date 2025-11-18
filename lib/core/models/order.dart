import 'cart_item.dart';

class Order {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final String status;
  final String addressSummary;
  final String deliveryEstimate;
  final String paymentMethod;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.status,
    required this.addressSummary,
    required this.deliveryEstimate,
    required this.paymentMethod,
  });

  double get subtotal => items.fold(0, (p, e) => p + e.total);
  double get deliveryFee => 12;
  double get total => subtotal + deliveryFee;
}
