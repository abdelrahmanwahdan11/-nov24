import '../models/coupon.dart';

final mockCoupons = [
  Coupon(
    code: 'GLOW15',
    description: '15% off your next serum',
    discountPercent: 15,
    expiresOn: DateTime.now().add(const Duration(days: 14)),
    isApplied: true,
  ),
  Coupon(
    code: 'SOOTHE10',
    description: 'Calming bundle savings',
    discountPercent: 10,
    expiresOn: DateTime.now().add(const Duration(days: 30)),
  ),
  Coupon(
    code: 'HYDRATE20',
    description: '20% off hydration refills',
    discountPercent: 20,
    expiresOn: DateTime.now().add(const Duration(days: 5)),
  ),
];
