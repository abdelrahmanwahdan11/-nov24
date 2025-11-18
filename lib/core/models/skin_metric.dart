import 'package:flutter/material.dart';

class SkinMetric {
  final DateTime date;
  final double hydration; // 0-1 scale
  final double radiance; // 0-1 scale
  final int breakouts; // count per day
  final String note;

  const SkinMetric({
    required this.date,
    required this.hydration,
    required this.radiance,
    required this.breakouts,
    required this.note,
  });

  String formatDate(BuildContext context) {
    final format = MaterialLocalizations.of(context).formatShortMonthDay;
    return format(date);
  }
}

