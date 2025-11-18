import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('rewards'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: scope.engagementController.rewardPoints,
              builder: (_, points, __) {
                final progress = (points as int) / 1000;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${loc.t('current_points')}: $points'),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        minHeight: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(loc.t('next_tier_hint')),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Text(loc.t('perks'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...[
              loc.t('perk_fast_shipping'),
              loc.t('perk_skin_coach'),
              loc.t('perk_gifts'),
            ].map(
              (perk) => Card(
                child: ListTile(
                  leading: const Icon(Icons.stars_rounded),
                  title: Text(perk),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
