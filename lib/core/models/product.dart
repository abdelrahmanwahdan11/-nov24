import 'package:flutter/material.dart';

class Product {
  final String id;
  final String nameEn;
  final String nameAr;
  final double price;
  final String size;
  final double rating;
  final int reviewsCount;
  final String category;
  final String imageUrl;
  final String descriptionShortEn;
  final String descriptionShortAr;
  final String descriptionLongEn;
  final String descriptionLongAr;
  final List<String> tags;
  final bool isBestSeller;
  final bool isNew;
  final String skinType;
  bool isFavorite;

  Product({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.price,
    required this.size,
    required this.rating,
    required this.reviewsCount,
    required this.category,
    required this.imageUrl,
    required this.descriptionShortEn,
    required this.descriptionShortAr,
    required this.descriptionLongEn,
    required this.descriptionLongAr,
    required this.tags,
    required this.isBestSeller,
    required this.isNew,
    required this.skinType,
    this.isFavorite = false,
  });

  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      nameEn: nameEn,
      nameAr: nameAr,
      price: price,
      size: size,
      rating: rating,
      reviewsCount: reviewsCount,
      category: category,
      imageUrl: imageUrl,
      descriptionShortEn: descriptionShortEn,
      descriptionShortAr: descriptionShortAr,
      descriptionLongEn: descriptionLongEn,
      descriptionLongAr: descriptionLongAr,
      tags: tags,
      isBestSeller: isBestSeller,
      isNew: isNew,
      skinType: skinType,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  String localizedName(Locale locale) =>
      locale.languageCode == 'ar' ? nameAr : nameEn;

  String localizedShortDescription(Locale locale) =>
      locale.languageCode == 'ar' ? descriptionShortAr : descriptionShortEn;

  String localizedLongDescription(Locale locale) =>
      locale.languageCode == 'ar' ? descriptionLongAr : descriptionLongEn;
}
