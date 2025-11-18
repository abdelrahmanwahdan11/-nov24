import '../models/app_notification.dart';

final mockNotifications = <AppNotification>[
  AppNotification(
    id: 'n1',
    title: 'Limited offer',
    body: 'Extra glow serum is 20% off through Friday.',
    date: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  AppNotification(
    id: 'n2',
    title: 'Routine reminder',
    body: 'Remember to double-cleanse tonight for smoother skin.',
    date: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
  ),
  AppNotification(
    id: 'n3',
    title: 'New arrival',
    body: 'Velvet night mask just landed in the catalog.',
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
];
