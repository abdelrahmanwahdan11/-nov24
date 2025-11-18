import '../models/product_bundle.dart';

const mockBundles = [
  ProductBundle(
    id: 'b1',
    title: 'Brightening Ritual',
    subtitle: 'Vitamin C trio for glow',
    price: 118,
    imageUrl:
        'https://images.pexels.com/photos/965989/pexels-photo-965989.jpeg?auto=compress&cs=tinysrgb&w=800',
    productIds: ['p1', 'p2', 'p5'],
    benefits: [
      'Evens tone in 7 days',
      'Pairs with your morning SPF',
      'Layer-friendly textures',
    ],
  ),
  ProductBundle(
    id: 'b2',
    title: 'Barrier Rescue',
    subtitle: 'Calm + repair starter pack',
    price: 92,
    imageUrl:
        'https://images.pexels.com/photos/3735612/pexels-photo-3735612.jpeg?auto=compress&cs=tinysrgb&w=800',
    productIds: ['p3', 'p6', 'p4'],
    benefits: [
      'Ceramide-rich moisturizer',
      'Fragrance free',
      'Derm-approved routine',
    ],
  ),
  ProductBundle(
    id: 'b3',
    title: 'Sun-Kissed Duo',
    subtitle: 'SPF + after-sun nourishment',
    price: 64,
    imageUrl:
        'https://images.pexels.com/photos/1729986/pexels-photo-1729986.jpeg?auto=compress&cs=tinysrgb&w=800',
    productIds: ['p7', 'p8'],
    benefits: [
      'Lightweight daily SPF',
      'Soothing post-sun gel',
      'Travel-ready sizes',
    ],
  ),
];
