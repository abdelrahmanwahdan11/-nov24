import '../models/badge.dart';

final List<Badge> mockBadges = [
  const Badge(
    id: 'badge-streak',
    title: 'Consistency champ',
    description: 'Log 7 days of routines without skipping.',
    progress: 0.7,
    achieved: false,
  ),
  const Badge(
    id: 'badge-referral',
    title: 'Glow gifter',
    description: 'Share your referral code with 5 friends.',
    progress: 1,
    achieved: true,
  ),
  const Badge(
    id: 'badge-sos',
    title: 'Calm responder',
    description: 'Complete three SOS playbook flows.',
    progress: 0.33,
  ),
];
