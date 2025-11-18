import '../models/cart_item.dart';
import '../models/order.dart';
import 'mock_products.dart';

final mockOrders = <Order>[
  Order(
    id: 'o1',
    date: DateTime.now().subtract(const Duration(days: 3)),
    items: [
      CartItem(product: mockProducts[0], quantity: 1),
      CartItem(product: mockProducts[1], quantity: 2),
    ],
    status: 'delivered',
  ),
  Order(
    id: 'o2',
    date: DateTime.now().subtract(const Duration(days: 15)),
    items: [CartItem(product: mockProducts[2], quantity: 1)],
    status: 'processing',
  ),
];
