import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController {
  static const _seenKey = 'seen_onboarding';
  final PageController pageController = PageController();
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  Timer? _timer;

  void startAutoScroll(int length) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      final next = (pageIndex.value + 1) % length;
      pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void onPageChanged(int index, int length) {
    pageIndex.value = index;
    if (index == length - 1) {
      _timer?.cancel();
    }
  }

  Future<void> markSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, true);
  }

  Future<bool> hasSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenKey) ?? false;
  }

  void dispose() {
    _timer?.cancel();
    pageController.dispose();
  }
}
