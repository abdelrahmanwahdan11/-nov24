class TrackingEvent {
  final String title;
  final String timestamp;
  final String detail;
  final bool isDone;

  const TrackingEvent({
    required this.title,
    required this.timestamp,
    required this.detail,
    this.isDone = false,
  });
}
