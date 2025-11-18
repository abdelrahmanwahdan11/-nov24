import 'package:flutter/material.dart';
import '../localization/locale_controller.dart';
import '../theme/theme_controller.dart';

class SettingsController {
  final ThemeController themeController;
  final LocaleController localeController;

  SettingsController(this.themeController, this.localeController);

  ValueNotifier<ThemeMode> get themeMode => themeController.themeMode;
  ValueNotifier<Color> get primary => themeController.primaryColor;
  ValueNotifier<Locale> get locale => localeController.locale;

  Future<void> setThemeMode(ThemeMode mode) => themeController.updateThemeMode(mode);
  Future<void> setPrimary(Color color) => themeController.updatePrimary(color);
  Future<void> setLocale(Locale l) => localeController.updateLocale(l);
}
