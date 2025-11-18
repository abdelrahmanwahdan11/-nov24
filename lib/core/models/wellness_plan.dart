class WellnessPlanTask {
  final String title;
  final bool completed;

  const WellnessPlanTask({required this.title, this.completed = false});

  WellnessPlanTask copyWith({bool? completed}) {
    return WellnessPlanTask(title: title, completed: completed ?? this.completed);
  }

  WellnessPlanTask toggle() => copyWith(completed: !completed);
}

class WellnessPlanDay {
  final String id;
  final String dayLabel;
  final String focus;
  final List<WellnessPlanTask> tasks;
  final String tip;

  const WellnessPlanDay({
    required this.id,
    required this.dayLabel,
    required this.focus,
    required this.tasks,
    required this.tip,
  });

  WellnessPlanDay copyWith({List<WellnessPlanTask>? tasks}) {
    return WellnessPlanDay(
      id: id,
      dayLabel: dayLabel,
      focus: focus,
      tasks: tasks ?? this.tasks,
      tip: tip,
    );
  }

  int get completedCount => tasks.where((t) => t.completed).length;
}
