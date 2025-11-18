import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class WellnessDashboardScreen extends StatelessWidget {
  const WellnessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('wellness_dashboard'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.t('daily_overview'), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: loc.t('routine_streak'),
                    icon: Icons.local_fire_department_outlined,
                    notifier: scope.engagementController.routineStreak,
                    suffix: loc.t('days'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: loc.t('completed_routines'),
                    icon: Icons.check_circle_outline,
                    notifier: scope.engagementController.completedRoutines,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: loc.t('current_points'),
                    icon: Icons.card_giftcard_outlined,
                    notifier: scope.engagementController.rewardPoints,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: loc.t('referrals_shared'),
                    icon: Icons.share_outlined,
                    notifier: scope.engagementController.sharedReferrals,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(loc.t('actions'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: scope.engagementController.completeRoutine,
                  icon: const Icon(Icons.checklist_rtl),
                  label: Text(loc.t('complete_routine')),
                ),
                OutlinedButton.icon(
                  onPressed: scope.engagementController.resetStreak,
                  icon: const Icon(Icons.restart_alt),
                  label: Text(loc.t('reset_streak')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: scope.engagementController.challenges,
                builder: (_, challenges, __) {
                  if (challenges.isEmpty) {
                    return Center(child: Text(loc.t('no_challenges')));
                  }
                  return ListView.separated(
                    itemCount: challenges.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final challenge = challenges[index];
                      final completedTasks = challenge.tasks.where((t) => t.completed).length;
                      return ListTile(
                        tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        title: Text(challenge.title),
                        subtitle: Text('${completedTasks}/${challenge.tasks.length} ${loc.t('steps_done')}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.checklist),
                          onPressed: () => scope.engagementController.toggleChallengeTask(challenge.id, 0),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ValueNotifier<int> notifier;
  final String? suffix;
  const _StatCard({required this.title, required this.icon, required this.notifier, this.suffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      ),
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (_, value, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(height: 8),
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text(
                suffix != null ? '$value $suffix' : '$value',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          );
        },
      ),
    );
  }
}
