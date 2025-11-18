import 'package:flutter/material.dart';
import '../data/mock_addresses.dart';
import '../data/mock_notifications.dart';
import '../models/address.dart';
import '../models/app_notification.dart';
import '../models/routine_step.dart';
import '../models/skin_quiz_question.dart';
import '../models/skin_diary_entry.dart';
import '../models/skin_goal.dart';

class EngagementController {
  final ValueNotifier<List<AppNotification>> notifications =
      ValueNotifier(List.from(mockNotifications));
  final ValueNotifier<List<Address>> addresses =
      ValueNotifier(List.from(mockAddresses));
  final ValueNotifier<int> rewardPoints = ValueNotifier(640);
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
    quizResult.dispose();
    diaryEntries.dispose();
    nextConsultation.dispose();
    goals.dispose();
  }
}
