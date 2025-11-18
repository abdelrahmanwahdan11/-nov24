import 'cart_item.dart';

class Order {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final String status;

  Order({required this.id, required this.date, required this.items, required this.status});

  double get total => items.fold(0, (p, e) => p + e.total);
}
