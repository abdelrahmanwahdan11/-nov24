import '../models/subscription_plan.dart';

final mockSubscriptions = [
  SubscriptionPlan(
    id: 'sub1',
    title: 'Barrier Repair Set',
    productName: 'Ceramide Cleanser + Moisturizer',
    imageUrl:
        'https://images.pexels.com/photos/6890343/pexels-photo-6890343.jpeg?auto=compress&cs=tinysrgb&w=800',
    frequency: 'Every 4 weeks',
    price: 48,
    nextDelivery: DateTime.now().add(const Duration(days: 9)),
  ),
  SubscriptionPlan(
    id: 'sub2',
    title: 'Sunscreen Essentials',
    productName: 'Mineral SPF 50',
    imageUrl:
        'https://images.pexels.com/photos/3737594/pexels-photo-3737594.jpeg?auto=compress&cs=tinysrgb&w=800',
    frequency: 'Every 6 weeks',
    price: 22,
    nextDelivery: DateTime.now().add(const Duration(days: 21)),
    paused: true,
  ),
];
