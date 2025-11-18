import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final faqEntries = [
      (loc.t('faq_shipping_q'), loc.t('faq_shipping_a')),
      (loc.t('faq_returns_q'), loc.t('faq_returns_a')),
      (loc.t('faq_routine_q'), loc.t('faq_routine_a')),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('help'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(loc.t('faq'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...faqEntries.map(
            (entry) => Card(
              child: ExpansionTile(
                title: Text(entry.$1),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(entry.$2),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(loc.t('contact_us'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: Text(loc.t('email_support')),
            subtitle: const Text('care@glowstudio.app'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(loc.t('ai_dialog'))),
            ),
          ),
        ],
      ),
    );
  }
}
