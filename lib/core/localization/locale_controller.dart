import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController with ChangeNotifier {
  static const _localeKey = 'locale';
  final ValueNotifier<Locale> locale = ValueNotifier(const Locale('en'));

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);
    if (code != null) {
      locale.value = Locale(code);
    }
  }

  Future<void> updateLocale(Locale newLocale) async {
    locale.value = newLocale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, newLocale.languageCode);
  }
}
