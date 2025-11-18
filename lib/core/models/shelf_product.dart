class ShelfProduct {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final DateTime openedAt;
  final int shelfLifeMonths;
  final bool isOpen;
  final bool isFinished;
  final String note;

  const ShelfProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.openedAt,
    required this.shelfLifeMonths,
    this.isOpen = true,
    this.isFinished = false,
    this.note = '',
  });

  ShelfProduct copyWith({
    String? id,
    String? name,
    String? category,
    String? imageUrl,
    DateTime? openedAt,
    int? shelfLifeMonths,
    bool? isOpen,
    bool? isFinished,
    String? note,
  }) {
    return ShelfProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      openedAt: openedAt ?? this.openedAt,
      shelfLifeMonths: shelfLifeMonths ?? this.shelfLifeMonths,
      isOpen: isOpen ?? this.isOpen,
      isFinished: isFinished ?? this.isFinished,
      note: note ?? this.note,
    );
  }
}
