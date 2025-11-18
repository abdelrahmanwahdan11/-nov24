class RecallAlert {
  final String id;
  final String productName;
  final String lotCode;
  final String issue;
  final String action;
  final String severity;
  final DateTime expiresAt;
  final String imageUrl;
  final bool acknowledged;

  const RecallAlert({
    required this.id,
    required this.productName,
    required this.lotCode,
    required this.issue,
    required this.action,
    required this.severity,
    required this.expiresAt,
    required this.imageUrl,
    this.acknowledged = false,
  });

  RecallAlert copyWith({bool? acknowledged}) {
    return RecallAlert(
      id: id,
      productName: productName,
      lotCode: lotCode,
      issue: issue,
      action: action,
      severity: severity,
      expiresAt: expiresAt,
      imageUrl: imageUrl,
      acknowledged: acknowledged ?? this.acknowledged,
    );
  }
}
