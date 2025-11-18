import 'package:flutter/material.dart';
import '../data/mock_addresses.dart';
import '../data/mock_challenges.dart';
import '../data/mock_coupons.dart';
import '../data/mock_notifications.dart';
import '../data/mock_subscriptions.dart';
import '../models/address.dart';
import '../models/app_notification.dart';
import '../models/coupon.dart';
import '../models/routine_step.dart';
import '../models/skin_diary_entry.dart';
import '../models/skin_goal.dart';
import '../models/skin_quiz_question.dart';
import '../models/subscription_plan.dart';
import '../models/wellness_challenge.dart';

class EngagementController {
  final ValueNotifier<List<AppNotification>> notifications =
      ValueNotifier(List.from(mockNotifications));
  final ValueNotifier<List<Address>> addresses =
      ValueNotifier(List.from(mockAddresses));
  final ValueNotifier<int> rewardPoints = ValueNotifier(640);
  final ValueNotifier<int> routineStreak = ValueNotifier(5);
  final ValueNotifier<int> completedRoutines = ValueNotifier(14);
  final ValueNotifier<int> sharedReferrals = ValueNotifier(3);
  final ValueNotifier<String> referralCode = ValueNotifier('GLOW15');
  final ValueNotifier<List<Coupon>> coupons =
      ValueNotifier(List.from(mockCoupons));
  final ValueNotifier<List<SubscriptionPlan>> subscriptions =
      ValueNotifier(List.from(mockSubscriptions));
  final ValueNotifier<List<WellnessChallenge>> challenges =
      ValueNotifier(List.from(mockChallenges));
  final ValueNotifier<List<String>> quizResult = ValueNotifier(const []);
  final ValueNotifier<List<SkinDiaryEntry>> diaryEntries = ValueNotifier([
    SkinDiaryEntry(
      date: DateTime.now().subtract(const Duration(days: 1)),
      mood: 'Calm',
      note: 'Tried the rose serum and woke up hydrated.',
    ),
  ]);
  final ValueNotifier<DateTime?> nextConsultation = ValueNotifier(null);
  final ValueNotifier<List<SkinGoal>> goals = ValueNotifier(const [
    SkinGoal(
      id: 'g1',
      title: 'Fade dark spots',
      description: 'Vitamin C and SPF routine to even your tone.',
      tasks: [
        SkinGoalTask(title: 'Apply vitamin C every morning'),
        SkinGoalTask(title: 'Use SPF 50 daily'),
        SkinGoalTask(title: 'Track weekly progress photo'),
      ],
    ),
    SkinGoal(
      id: 'g2',
      title: 'Calm sensitivity',
      description: 'Repair your barrier with ceramides and gentle cleanse.',
      tasks: [
        SkinGoalTask(title: 'Use fragrance-free cleanser at night'),
        SkinGoalTask(title: 'Moisturize twice daily'),
        SkinGoalTask(title: 'Limit exfoliation to once a week'),
      ],
    ),
  ]);
  final List<DateTime> availableConsultations = List.generate(
    6,
    (index) => DateTime.now().add(Duration(days: index + 1, hours: 10 + index)),
  );

  List<RoutineStep> get morningRoutine => const [
        RoutineStep(
          title: 'Cleanser',
          subtitle: 'Gentle foaming cleanser to refresh skin',
          icon: Icons.water_drop,
        ),
        RoutineStep(
          title: 'Essence',
          subtitle: 'Hydrate and prep with niacinamide',
          icon: Icons.blur_on,
          waitTime: Duration(minutes: 2),
        ),
        RoutineStep(
          title: 'Moisturizer',
          subtitle: 'Lock in water with ceramides',
          icon: Icons.spa,
        ),
        RoutineStep(
          title: 'SPF 50',
          subtitle: 'Finish with broad-spectrum sunscreen',
          icon: Icons.wb_sunny_outlined,
        ),
      ];

  List<RoutineStep> get eveningRoutine => const [
        RoutineStep(
          title: 'Oil cleanse',
          subtitle: 'Melt makeup and impurities',
          icon: Icons.oil_barrel_outlined,
        ),
        RoutineStep(
          title: 'Water cleanse',
          subtitle: 'Second cleanse for pores',
          icon: Icons.waves,
          waitTime: Duration(minutes: 1),
        ),
        RoutineStep(
          title: 'Treatment',
          subtitle: 'Apply retinol twice weekly',
          icon: Icons.science_outlined,
          waitTime: Duration(minutes: 5),
        ),
        RoutineStep(
          title: 'Overnight mask',
          subtitle: 'Seal moisture while you sleep',
          icon: Icons.nightlight_round,
        ),
      ];

  List<SkinQuizQuestion> get quizQuestions => const [
        SkinQuizQuestion(
          question: 'How does your skin feel midday?',
          options: ['Balanced', 'Oily', 'Tight/dry', 'Mixed'],
        ),
        SkinQuizQuestion(
          question: 'Primary concern to solve?',
          options: ['Dark spots', 'Acne', 'Redness', 'Fine lines'],
        ),
        SkinQuizQuestion(
          question: 'Preferred texture?',
          options: ['Gel', 'Cream', 'Oil', 'Lightweight serum'],
        ),
      ];

  void markNotificationRead(String id) {
    final list = notifications.value.map((n) {
      if (n.id == id) {
        n.isRead = true;
      }
      return n;
    }).toList();
    notifications.value = list;
  }

  void markAllRead() {
    notifications.value =
        notifications.value.map((e) => e..isRead = true).toList();
  }

  void addAddress(Address address) {
    addresses.value = [...addresses.value, address];
  }

  void applyCoupon(String code) {
    final normalized = code.trim().toUpperCase();
    coupons.value = coupons.value
        .map((c) => c.code.toUpperCase() == normalized
            ? c.copyWith(isApplied: true)
            : c)
        .toList();
  }

  void toggleCoupon(String code) {
    final normalized = code.trim().toUpperCase();
    coupons.value = coupons.value
        .map((c) => c.code.toUpperCase() == normalized
            ? c.copyWith(isApplied: !c.isApplied)
            : c)
        .toList();
  }

  void completeRoutine() {
    completedRoutines.value = completedRoutines.value + 1;
    routineStreak.value = routineStreak.value + 1;
    rewardPoints.value = rewardPoints.value + 10;
  }

  void resetStreak() {
    routineStreak.value = 0;
  }

  void toggleSubscriptionPause(String id) {
    subscriptions.value = subscriptions.value.map((plan) {
      if (plan.id != id) return plan;
      return plan.copyWith(paused: !plan.paused);
    }).toList();
  }

  void skipNextDelivery(String id) {
    subscriptions.value = subscriptions.value.map((plan) {
      if (plan.id != id) return plan;
      return plan.copyWith(
        nextDelivery: plan.nextDelivery.add(const Duration(days: 7)),
      );
    }).toList();
  }

  void changeFrequency(String id) {
    const options = ['Every 4 weeks', 'Every 6 weeks', 'Every 8 weeks'];
    subscriptions.value = subscriptions.value.map((plan) {
      if (plan.id != id) return plan;
      final currentIndex = options.indexOf(plan.frequency);
      final nextIndex = (currentIndex + 1) % options.length;
      return plan.copyWith(frequency: options[nextIndex]);
    }).toList();
  }

  void toggleChallengeTask(String challengeId, int index) {
    challenges.value = challenges.value.map((challenge) {
      if (challenge.id != challengeId) return challenge;
      final updatedTasks = [...challenge.tasks];
      if (index >= 0 && index < updatedTasks.length) {
        updatedTasks[index] = updatedTasks[index].toggle();
      }
      return challenge.copyWith(tasks: updatedTasks);
    }).toList();
  }

  void selectQuizAnswers(List<String> answers) {
    quizResult.value = answers;
  }

  void addDiaryEntry(String mood, String note) {
    final entry = SkinDiaryEntry(date: DateTime.now(), mood: mood, note: note);
    diaryEntries.value = [entry, ...diaryEntries.value];
  }

  void bookConsultation(DateTime slot) {
    nextConsultation.value = slot;
  }

  void toggleGoalStep(String goalId, int index) {
    goals.value = goals.value.map((goal) {
      if (goal.id != goalId) return goal;
      final updatedTasks = [...goal.tasks];
      if (index >= 0 && index < updatedTasks.length) {
        updatedTasks[index] = updatedTasks[index].toggle();
      }
      return goal.copyWith(tasks: updatedTasks);
    }).toList();
  }

  String deriveQuizSummary() {
    if (quizResult.value.isEmpty) return 'balanced';
    final hasOil = quizResult.value.any((e) => e.contains('Oily'));
    final hasDry = quizResult.value.any((e) => e.contains('dry'));
    if (hasOil && hasDry) return 'combination';
    if (hasOil) return 'oily';
    if (hasDry) return 'dry';
    return 'balanced';
  }

  void dispose() {
    notifications.dispose();
    addresses.dispose();
    rewardPoints.dispose();
    routineStreak.dispose();
    completedRoutines.dispose();
    sharedReferrals.dispose();
    quizResult.dispose();
    diaryEntries.dispose();
    nextConsultation.dispose();
    goals.dispose();
    referralCode.dispose();
    coupons.dispose();
    subscriptions.dispose();
    challenges.dispose();
  }
}
