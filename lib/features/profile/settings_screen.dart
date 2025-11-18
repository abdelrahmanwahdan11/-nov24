import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/theme_controller.dart';
import '../../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    final colors = [const Color(0xFFB87333), Colors.teal, Colors.pink];
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('settings'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.t('theme'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: scope.settingsController.themeMode,
              builder: (_, mode, __) {
                return SwitchListTile(
                  title: Text(loc.t('dark_mode')),
                  value: mode == ThemeMode.dark,
                  onChanged: (val) => scope.settingsController
                      .setThemeMode(val ? ThemeMode.dark : ThemeMode.light),
                );
              },
            ),
            const SizedBox(height: 12),
            Text(loc.t('primary_color'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: colors
                  .map((c) => GestureDetector(
                        onTap: () => scope.settingsController.setPrimary(c),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: c,
                            border: Border.all(color: Colors.black12),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            Text(loc.t('language'), style: Theme.of(context).textTheme.titleMedium),
            ValueListenableBuilder(
              valueListenable: scope.settingsController.locale,
              builder: (_, locale, __) {
                return Column(
                  children: [
                    RadioListTile(
                      value: const Locale('en'),
                      groupValue: locale,
                      onChanged: (v) => scope.settingsController.setLocale(v!),
                      title: const Text('English'),
                    ),
                    RadioListTile(
                      value: const Locale('ar'),
                      groupValue: locale,
                      onChanged: (v) => scope.settingsController.setLocale(v!),
                      title: const Text('العربية'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
