import 'package:flutter/material.dart';
import '../data/mock_addresses.dart';
import '../data/mock_challenges.dart';
import '../data/mock_coupons.dart';
import '../data/mock_notifications.dart';
import '../data/mock_subscriptions.dart';
import '../data/mock_ingredients.dart';
import '../models/ingredient.dart';
import '../models/address.dart';
import '../models/app_notification.dart';
import '../models/coupon.dart';
import '../models/coach_qna.dart';
import '../models/routine_step.dart';
import '../models/skin_diary_entry.dart';
import '../models/skin_goal.dart';
import '../models/skin_quiz_question.dart';
import '../models/subscription_plan.dart';
import '../models/wellness_challenge.dart';
import '../models/wellness_plan.dart';
import '../models/skin_metric.dart';
import '../models/tracking_event.dart';
import '../models/travel_kit_item.dart';

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
  final ValueNotifier<List<CoachQna>> coachQna = ValueNotifier([
    CoachQna(
      id: 'q1',
      question: 'How should I layer serums for oily T-zone?',
      answer: 'Start watery textures first, then gel, seal with a light cream.',
      isAnswered: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    CoachQna(
      id: 'q2',
      question: 'Traveling to humid weather—what to pack?',
      answer: 'Bring minis of cleanser, mist, gel moisturizer, and SPF stick.',
      isAnswered: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ]);
  final ValueNotifier<List<TravelKitItem>> travelKit = ValueNotifier(const [
    TravelKitItem(
      id: 'pack-cleanser',
      title: 'Cleanser mini',
      subtitle: 'Leak-proof tube for security checks',
    ),
    TravelKitItem(
      id: 'pack-spf',
      title: 'SPF stick',
      subtitle: 'Cabin-safe and easy to reapply',
    ),
    TravelKitItem(
      id: 'pack-mask',
      title: 'Soothing mask',
      subtitle: 'For flights longer than 4 hours',
    ),
    TravelKitItem(
      id: 'pack-hydrator',
      title: 'Hydrating mist',
      subtitle: 'Refresh before landing',
    ),
    TravelKitItem(
      id: 'pack-zip',
      title: 'Zip pouch',
      subtitle: 'Keep liquids together',
    ),
  ]);
  final ValueNotifier<String> travelClimate =
      ValueNotifier('Dry cabin · pack humectants');
  final ValueNotifier<List<SkinMetric>> skinMetrics = ValueNotifier([
    SkinMetric(
      date: DateTime.now().subtract(const Duration(days: 2)),
      hydration: 0.68,
      radiance: 0.62,
      breakouts: 2,
      note: 'Slept late—added barrier cream and extra water today.',
    ),
    SkinMetric(
      date: DateTime.now().subtract(const Duration(days: 1)),
      hydration: 0.74,
      radiance: 0.7,
      breakouts: 1,
      note: 'Used calming mask and SPF reapplication.',
    ),
    SkinMetric(
      date: DateTime.now(),
      hydration: 0.8,
      radiance: 0.78,
      breakouts: 0,
      note: 'Drank 2L water, added niacinamide serum.',
    ),
  ]);
  final ValueNotifier<bool> morningReminderEnabled = ValueNotifier(true);
  final ValueNotifier<bool> eveningReminderEnabled = ValueNotifier(true);
  final ValueNotifier<TimeOfDay> morningReminderTime =
      ValueNotifier(const TimeOfDay(hour: 7, minute: 30));
  final ValueNotifier<TimeOfDay> eveningReminderTime =
      ValueNotifier(const TimeOfDay(hour: 21, minute: 0));
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
  final ValueNotifier<List<Ingredient>> ingredients =
      ValueNotifier(List.from(mockIngredients));
  final ValueNotifier<List<WellnessPlanDay>> carePlan = ValueNotifier([
    WellnessPlanDay(
      id: 'plan-mon',
      dayLabel: 'Monday',
      focus: 'Hydration reset',
      tip: 'Layer humectants on damp skin, then seal with moisturizer.',
      tasks: const [
        WellnessPlanTask(title: 'Double cleanse at night'),
        WellnessPlanTask(title: 'Mist + hydrating serum'),
        WellnessPlanTask(title: 'Rich moisturizer before bed'),
      ],
    ),
    WellnessPlanDay(
      id: 'plan-tue',
      dayLabel: 'Tuesday',
      focus: 'Clarify + calm',
      tip: 'Follow exfoliation with a soothing serum to avoid dryness.',
      tasks: const [
        WellnessPlanTask(title: 'BHA toner at PM'),
        WellnessPlanTask(title: 'Spot treat blemishes'),
        WellnessPlanTask(title: 'Barrier cream to finish'),
      ],
    ),
    WellnessPlanDay(
      id: 'plan-wed',
      dayLabel: 'Wednesday',
      focus: 'Brighten tone',
      tip: 'Pair vitamin C with sunscreen for amplified glow.',
      tasks: const [
        WellnessPlanTask(title: 'Vitamin C serum AM'),
        WellnessPlanTask(title: 'Lightweight gel moisturizer'),
        WellnessPlanTask(title: 'SPF 50 reapply at midday'),
      ],
    ),
    WellnessPlanDay(
      id: 'plan-thu',
      dayLabel: 'Thursday',
      focus: 'Barrier night',
      tip: 'Skip strong actives and layer ceramides when skin feels tight.',
      tasks: const [
        WellnessPlanTask(title: 'Cream cleanser'),
        WellnessPlanTask(title: 'Ceramide serum'),
        WellnessPlanTask(title: 'Overnight recovery mask'),
      ],
    ),
    WellnessPlanDay(
      id: 'plan-fri',
      dayLabel: 'Friday',
      focus: 'Retinol focus',
      tip: 'Keep retinol nights simple: cleanse, retinol, moisturize.',
      tasks: const [
        WellnessPlanTask(title: 'Gentle cleanse'),
        WellnessPlanTask(title: 'Retinol pea-size amount'),
        WellnessPlanTask(title: 'Buffer with moisturizer'),
      ],
    ),
    WellnessPlanDay(
      id: 'plan-sat',
      dayLabel: 'Saturday',
      focus: 'Recovery + massage',
      tip: 'Use facial oil for slip and lymphatic drainage massage.',
      tasks: const [
        WellnessPlanTask(title: 'Brightening mask morning'),
        WellnessPlanTask(title: 'Face massage with oil'),
        WellnessPlanTask(title: 'SPF + hat outdoors'),
      ],
    ),
    WellnessPlanDay(
      id: 'plan-sun',
      dayLabel: 'Sunday',
      focus: 'Prep next week',
      tip: 'Refill minis, clean brushes, and set reminders for sunscreen.',
      tasks: const [
        WellnessPlanTask(title: 'Gentle enzyme exfoliation'),
        WellnessPlanTask(title: 'Deep moisturize lips + eyes'),
        WellnessPlanTask(title: 'Clean tools and gua sha'),
      ],
    ),
  ]);
  final ValueNotifier<Set<String>> completedPlanDays =
      ValueNotifier(<String>{});
  final ValueNotifier<List<TrackingEvent>> timelineEvents = ValueNotifier([
    const TrackingEvent(
      title: 'Routine complete',
      timestamp: 'Today · 8:05 AM',
      detail: 'Finished morning cleanse, essence, and SPF.',
      isDone: true,
    ),
    const TrackingEvent(
      title: 'Hydration check-in',
      timestamp: 'Yesterday · 10:15 PM',
      detail: 'Hydration 0.74 • Radiance 0.70 • Breakouts 1',
      isDone: true,
    ),
    const TrackingEvent(
      title: 'Evening reminder snoozed',
      timestamp: 'Mon · 9:15 PM',
      detail: 'Evening reminder moved by 30 minutes.',
    ),
    const TrackingEvent(
      title: 'New care plan tip',
      timestamp: 'Sun · 5:45 PM',
      detail: 'Swap exfoliation for soothing mask when skin feels warm.',
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

  void addCoachQuestion(String prompt) {
    if (prompt.trim().isEmpty) return;
    final entry = CoachQna(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      question: prompt.trim(),
      answer: 'We will craft a tailored tip and drop it here soon.',
      isAnswered: false,
      createdAt: DateTime.now(),
    );
    coachQna.value = [entry, ...coachQna.value];
  }

  void toggleTravelItem(String id) {
    travelKit.value = travelKit.value
        .map((item) => item.id == id
            ? item.copyWith(packed: !item.packed)
            : item)
        .toList();
  }

  void setTravelClimate(String label) {
    travelClimate.value = label;
  }

  void logSkinMetric(SkinMetric metric) {
    final updated = [metric, ...skinMetrics.value]
      ..sort((a, b) => b.date.compareTo(a.date));
    skinMetrics.value = updated;
    timelineEvents.value = [
      TrackingEvent(
        title: 'Hydration check-in',
        timestamp: '${metric.date.month}/${metric.date.day} · ${metric.date.hour}:${metric.date.minute.toString().padLeft(2, '0')}',
        detail:
            'Hydration ${(metric.hydration * 100).toStringAsFixed(0)}% • Radiance ${(metric.radiance * 100).toStringAsFixed(0)}% • Breakouts ${metric.breakouts}',
        isDone: true,
      ),
      ...timelineEvents.value,
    ];
  }

  void toggleReminder({required bool morning, required bool enabled}) {
    if (morning) {
      morningReminderEnabled.value = enabled;
    } else {
      eveningReminderEnabled.value = enabled;
    }
  }

  void updateReminderTime({required bool morning, required TimeOfDay time}) {
    if (morning) {
      morningReminderTime.value = time;
    } else {
      eveningReminderTime.value = time;
    }
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

  void togglePlanTask(String dayId, int taskIndex) {
    carePlan.value = carePlan.value.map((day) {
      if (day.id != dayId) return day;
      final updated = [...day.tasks];
      if (taskIndex >= 0 && taskIndex < updated.length) {
        updated[taskIndex] = updated[taskIndex].toggle();
      }
      return day.copyWith(tasks: updated);
    }).toList();
  }

  void resetPlanProgress() {
    carePlan.value = carePlan.value
        .map((day) => day.copyWith(
            tasks: day.tasks.map((task) => task.copyWith(completed: false)).toList()))
        .toList();
    completedPlanDays.value = <String>{};
  }

  void togglePlanDay(String dayId) {
    final next = {...completedPlanDays.value};
    if (next.contains(dayId)) {
      next.remove(dayId);
    } else {
      next.add(dayId);
    }
    completedPlanDays.value = next;
  }

  Map<String, double> weeklySkinAverages() {
    final recent = skinMetrics.value.take(7).toList();
    if (recent.isEmpty) return {'hydration': 0, 'radiance': 0, 'breakouts': 0};
    final hydration =
        recent.map((m) => m.hydration).reduce((a, b) => a + b) / recent.length;
    final radiance =
        recent.map((m) => m.radiance).reduce((a, b) => a + b) / recent.length;
    final breakouts =
        recent.map((m) => m.breakouts).reduce((a, b) => a + b) / recent.length;
    return {
      'hydration': hydration,
      'radiance': radiance,
      'breakouts': breakouts,
    };
  }

  List<String> deriveInsights() {
    final averages = weeklySkinAverages();
    final insights = <String>[];
    if (averages['hydration']! < 0.65) {
      insights.add(
          'Boost hydration with humectants and seal with moisturizer on damp skin.');
    } else {
      insights.add('Hydration is trending solid—keep misting before serums.');
    }
    if (averages['radiance']! < 0.6) {
      insights.add('Add a gentle brightening serum twice weekly to lift radiance.');
    }
    if (averages['breakouts']! > 1.5) {
      insights.add('Breakouts spiked—pair BHA nights with barrier-repair moisturizers.');
    }
    if (timelineEvents.value.length > 3) {
      insights.add('Nice streak! Convert logs into a printable skin report anytime.');
    }
    return insights;
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
    ingredients.dispose();
    carePlan.dispose();
    skinMetrics.dispose();
    completedPlanDays.dispose();
    timelineEvents.dispose();
    morningReminderEnabled.dispose();
    eveningReminderEnabled.dispose();
    morningReminderTime.dispose();
    eveningReminderTime.dispose();
    coachQna.dispose();
    travelKit.dispose();
    travelClimate.dispose();
  }
}
