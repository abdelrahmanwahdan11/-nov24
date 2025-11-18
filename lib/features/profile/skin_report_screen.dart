import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class SkinReportScreen extends StatelessWidget {
  const SkinReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('skin_report'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: scope.engagementController.diaryEntries,
              builder: (_, entries, __) {
                final moods = entries.map((e) => e.mood).toList();
                return _ReportCard(
                  title: loc.t('diary_entries'),
                  description: '${moods.length} ${loc.t('entries_logged')}',
                  trailing: moods.isNotEmpty ? moods.first : 'Balanced',
                );
              },
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder(
              valueListenable: scope.engagementController.goals,
              builder: (_, goals, __) {
                final completed = goals
                    .expand((g) => g.tasks)
                    .where((t) => t.done)
                    .length;
                final total = goals.expand((g) => g.tasks).length;
                final progress = total == 0 ? 0 : (completed / total * 100).round();
                return _ReportCard(
                  title: loc.t('goal_progress'),
                  description: loc.t('goal_progress_detail').replaceFirst('{p}', '$progress'),
                  trailing: '$progress%',
                );
              },
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder(
              valueListenable: scope.engagementController.challenges,
              builder: (_, challenges, __) {
                final progress = challenges.isEmpty
                    ? 0
                    : challenges
                            .map((c) =>
                                c.tasks.isEmpty ? 0.0 : c.completedTasks / c.tasks.length)
                            .reduce((a, b) => a + b) /
                        challenges.length;
                return _ReportCard(
                  title: loc.t('challenge_summary'),
                  description: loc.t('challenge_detail'),
                  trailing: '${(progress * 100).round()}%',
                );
              },
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder(
              valueListenable: scope.engagementController.rewardPoints,
              builder: (_, points, __) {
                return _ReportCard(
                  title: loc.t('rewards'),
                  description: loc.t('points_balance').replaceFirst('{p}', '$points'),
                  trailing: loc.t('next_tier_hint'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String description;
  final String trailing;
  const _ReportCard({required this.title, required this.description, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(description, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(trailing, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
