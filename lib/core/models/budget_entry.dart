class BudgetEntry {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final bool isPlanned;
  final String note;
  final bool isPaid;

  const BudgetEntry({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.isPlanned = true,
    this.note = '',
    this.isPaid = false,
  });

  BudgetEntry copyWith({
    String? id,
    String? title,
    double? amount,
    String? category,
    DateTime? date,
    bool? isPlanned,
    String? note,
    bool? isPaid,
  }) {
    return BudgetEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      isPlanned: isPlanned ?? this.isPlanned,
      note: note ?? this.note,
      isPaid: isPaid ?? this.isPaid,
    );
  }
}
