class Ingredient {
  final String id;
  final String nameEn;
  final String nameAr;
  final String summaryEn;
  final String summaryAr;
  final List<String> benefitsEn;
  final List<String> benefitsAr;
  final String cautionEn;
  final String cautionAr;
  final List<String> concerns;
  final String imageUrl;

  const Ingredient({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.summaryEn,
    required this.summaryAr,
    required this.benefitsEn,
    required this.benefitsAr,
    required this.cautionEn,
    required this.cautionAr,
    required this.concerns,
    required this.imageUrl,
  });

  String name(String languageCode) => languageCode == 'ar' ? nameAr : nameEn;

  String summary(String languageCode) =>
      languageCode == 'ar' ? summaryAr : summaryEn;

  List<String> benefits(String languageCode) =>
      languageCode == 'ar' ? benefitsAr : benefitsEn;

  String caution(String languageCode) =>
      languageCode == 'ar' ? cautionAr : cautionEn;
}
