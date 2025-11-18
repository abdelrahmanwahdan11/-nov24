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
    addressSummary: 'Villa 12, Palm Avenue, Riyadh',
    deliveryEstimate: 'Arrived Tue, 7:30 pm',
    paymentMethod: 'Apple Pay',
  ),
  Order(
    id: 'o2',
    date: DateTime.now().subtract(const Duration(days: 15)),
    items: [CartItem(product: mockProducts[2], quantity: 1)],
    status: 'processing',
    addressSummary: 'Sky Tower, Jeddah',
    deliveryEstimate: 'Est. Fri, 2:00 pm',
    paymentMethod: 'Visa',
  ),
];
