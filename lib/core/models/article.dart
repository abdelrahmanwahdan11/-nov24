class Article {
  final String id;
  final String titleEn;
  final String titleAr;
  final String summaryEn;
  final String summaryAr;
  final String imageUrl;
  final int minutesRead;
  final String tag;

  const Article({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.summaryEn,
    required this.summaryAr,
    required this.imageUrl,
    required this.minutesRead,
    required this.tag,
  });

  String localizedTitle(String code) => code == 'ar' ? titleAr : titleEn;
  String localizedSummary(String code) => code == 'ar' ? summaryAr : summaryEn;
}
