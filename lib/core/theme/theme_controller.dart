import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController with ChangeNotifier {
  static const _themeModeKey = 'theme_mode';
  static const _primaryKey = 'primary_color';
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);
  final ValueNotifier<Color> primaryColor =
      ValueNotifier(const Color(0xFFB87333));

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt(_themeModeKey);
    if (modeIndex != null) {
      themeMode.value = ThemeMode.values[modeIndex];
    }
    final colorValue = prefs.getInt(_primaryKey);
    if (colorValue != null) {
      primaryColor.value = Color(colorValue);
    }
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  Future<void> updatePrimary(Color color) async {
    primaryColor.value = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_primaryKey, color.value);
  }
}
