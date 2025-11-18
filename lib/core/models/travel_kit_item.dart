class TravelKitItem {
  final String id;
  final String title;
  final String subtitle;
  final bool packed;

  const TravelKitItem({
    required this.id,
    required this.title,
    required this.subtitle,
    this.packed = false,
  });

  TravelKitItem copyWith({bool? packed}) {
    return TravelKitItem(
      id: id,
      title: title,
      subtitle: subtitle,
      packed: packed ?? this.packed,
    );
  }
}
