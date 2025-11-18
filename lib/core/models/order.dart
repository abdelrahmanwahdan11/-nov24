import 'cart_item.dart';
import 'tracking_event.dart';

class Order {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final String status;
  final String addressSummary;
  final String deliveryEstimate;
  final String paymentMethod;
  final List<TrackingEvent> tracking;
  final String carrier;
  final String trackingCode;
  final bool canReorder;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.status,
    required this.addressSummary,
    required this.deliveryEstimate,
    required this.paymentMethod,
    this.tracking = const [],
    this.carrier = 'Courier',
    this.trackingCode = '',
    this.canReorder = true,
  });

  double get subtotal => items.fold(0, (p, e) => p + e.total);
  double get deliveryFee => 12;
  double get total => subtotal + deliveryFee;
}
