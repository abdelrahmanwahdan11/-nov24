import 'package:flutter/material.dart';

class RoutineStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final Duration? waitTime;

  const RoutineStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.waitTime,
  });
}
