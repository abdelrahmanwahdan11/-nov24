import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';

class PatchTestScreen extends StatelessWidget {
  const PatchTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final steps = [
      (
        loc.t('patch_prep'),
        loc.t('patch_prep_detail'),
        Icons.clean_hands_outlined,
      ),
      (
        loc.t('patch_apply'),
        loc.t('patch_apply_detail'),
        Icons.spa_outlined,
      ),
      (
        loc.t('patch_wait'),
        loc.t('patch_wait_detail'),
        Icons.hourglass_bottom,
      ),
      (
        loc.t('patch_read'),
        loc.t('patch_read_detail'),
        Icons.visibility_outlined,
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('patch_test'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(loc.t('patch_test_intro'),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).hintColor)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text(loc.t('patch_area'))),
              Chip(label: Text(loc.t('patch_time'))),
              Chip(label: Text(loc.t('patch_stop'))),
            ],
          ),
          const SizedBox(height: 16),
          ...steps.map((step) => _PatchCard(title: step.$1, detail: step.$2, icon: step.$3)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(width: 8),
                      Text(loc.t('patch_tip'),
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(loc.t('patch_tip_detail'),
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text(loc.t('patch_stop_detail'),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).colorScheme.error)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatchCard extends StatelessWidget {
  final String title;
  final String detail;
  final IconData icon;
  const _PatchCard({required this.title, required this.detail, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(detail),
      ),
    );
  }
}
