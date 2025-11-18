class Badge {
  final String id;
  final String title;
  final String description;
  final double progress;
  final bool achieved;
  const Badge({
    required this.id,
    required this.title,
    required this.description,
    this.progress = 0,
    this.achieved = false,
  });

  Badge copyWith({double? progress, bool? achieved}) {
    return Badge(
      id: id,
      title: title,
      description: description,
      progress: progress ?? this.progress,
      achieved: achieved ?? this.achieved,
    );
  }
}
