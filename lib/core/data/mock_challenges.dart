import '../models/wellness_challenge.dart';

final mockChallenges = [
  WellnessChallenge(
    id: 'ch1',
    title: '14-day glow reset',
    description: 'Daily hydration, SPF, and barrier support tasks.',
    durationDays: 14,
    tasks: const [
      ChallengeTask(title: 'Drink 2L water'),
      ChallengeTask(title: 'Apply SPF before noon'),
      ChallengeTask(title: 'Nighttime moisturizer check-in'),
    ],
  ),
  WellnessChallenge(
    id: 'ch2',
    title: 'Calm & Soothe week',
    description: 'Seven days of fragrance-free, barrier-friendly routine.',
    durationDays: 7,
    tasks: const [
      ChallengeTask(title: 'Skip exfoliation today'),
      ChallengeTask(title: 'Use a cool compress for 5 minutes'),
      ChallengeTask(title: 'Log any redness triggers'),
    ],
  ),
];
