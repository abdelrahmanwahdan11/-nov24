class SkinGoalTask {
  final String title;
  final bool done;

  const SkinGoalTask({required this.title, this.done = false});

  SkinGoalTask toggle() => SkinGoalTask(title: title, done: !done);
}

class SkinGoal {
  final String id;
  final String title;
  final String description;
  final List<SkinGoalTask> tasks;

  const SkinGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.tasks,
  });

  double get progress => tasks.isEmpty
      ? 0
      : tasks.where((t) => t.done).length / tasks.length;

  SkinGoal copyWith({List<SkinGoalTask>? tasks}) {
    return SkinGoal(
      id: id,
      title: title,
      description: description,
      tasks: tasks ?? this.tasks,
    );
  }
}
