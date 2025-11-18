import '../models/cart_item.dart';
import '../models/order.dart';
import '../models/tracking_event.dart';
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
    carrier: 'Aramex',
    trackingCode: 'ARX-39422',
    tracking: const [
      TrackingEvent(
        title: 'Packed',
        timestamp: 'Mon 10:10',
        detail: 'Your skin set was prepared at the studio.',
        isDone: true,
      ),
      TrackingEvent(
        title: 'Shipped',
        timestamp: 'Mon 13:40',
        detail: 'Courier picked up the parcel.',
        isDone: true,
      ),
      TrackingEvent(
        title: 'Out for delivery',
        timestamp: 'Tue 16:00',
        detail: 'Driver is heading to your address.',
        isDone: true,
      ),
      TrackingEvent(
        title: 'Delivered',
        timestamp: 'Tue 19:30',
        detail: 'Left with concierge at reception.',
        isDone: true,
      ),
    ],
  ),
  Order(
    id: 'o2',
    date: DateTime.now().subtract(const Duration(days: 15)),
    items: [CartItem(product: mockProducts[2], quantity: 1)],
    status: 'processing',
    addressSummary: 'Sky Tower, Jeddah',
    deliveryEstimate: 'Est. Fri, 2:00 pm',
    paymentMethod: 'Visa',
    carrier: 'DHL',
    trackingCode: 'DHL-77410',
    tracking: const [
      TrackingEvent(
        title: 'Order confirmed',
        timestamp: 'Wed 09:00',
        detail: 'We are preparing your hydrating picks.',
        isDone: true,
      ),
      TrackingEvent(
        title: 'Packing',
        timestamp: 'Thu 11:20',
        detail: 'Items are being bubble wrapped.',
        isDone: false,
      ),
      TrackingEvent(
        title: 'Ready to ship',
        timestamp: 'Scheduled',
        detail: 'Label created, waiting for carrier scan.',
        isDone: false,
      ),
    ],
  ),
];
