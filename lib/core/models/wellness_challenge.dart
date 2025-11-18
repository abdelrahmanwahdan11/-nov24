class ChallengeTask {
  final String title;
  final bool isDone;

  const ChallengeTask({required this.title, this.isDone = false});

  ChallengeTask toggle() => ChallengeTask(title: title, isDone: !isDone);
}

class WellnessChallenge {
  final String id;
  final String title;
  final String description;
  final int durationDays;
  final List<ChallengeTask> tasks;

  const WellnessChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.durationDays,
    required this.tasks,
  });

  int get completedTasks => tasks.where((t) => t.isDone).length;

  WellnessChallenge copyWith({List<ChallengeTask>? tasks}) {
    return WellnessChallenge(
      id: id,
      title: title,
      description: description,
      durationDays: durationDays,
      tasks: tasks ?? this.tasks,
    );
  }
}
