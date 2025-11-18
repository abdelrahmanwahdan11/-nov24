import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('about'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.spa_rounded)),
              title: Text(loc.t('app_name')),
              subtitle: Text(loc.t('about_description')),
              trailing: Text(loc.t('app_version') + ' 1.0.0'),
            ),
          ),
          const SizedBox(height: 16),
          Text(loc.t('app_story'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(loc.t('mission')),
          const SizedBox(height: 16),
          Text(loc.t('highlights'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...[
            loc.t('wellness_hub'),
            loc.t('take_quiz'),
            loc.t('plan_routine'),
            loc.t('track_rewards'),
          ].map((item) => ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(item),
              )),
          const SizedBox(height: 16),
          Text(loc.t('privacy'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(loc.t('ai_dialog')),
          const SizedBox(height: 8),
          Text(loc.t('terms'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(loc.t('contact_us')),
        ],
      ),
    );
  }
}
