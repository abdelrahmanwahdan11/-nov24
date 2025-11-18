import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('challenges'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: scope.engagementController.challenges,
          builder: (_, list, __) {
            if (list.isEmpty) return Center(child: Text(loc.t('empty_challenges')));
            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final challenge = list[index];
                final progress = challenge.tasks.isEmpty
                    ? 0.0
                    : challenge.completedTasks / challenge.tasks.length;
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(challenge.title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(challenge.description),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(value: progress),
                        const SizedBox(height: 8),
                        Text('${(progress * 100).toStringAsFixed(0)}% ${loc.t('complete')}'),
                        const SizedBox(height: 12),
                        ...List.generate(challenge.tasks.length, (taskIndex) {
                          final task = challenge.tasks[taskIndex];
                          return CheckboxListTile(
                            value: task.isDone,
                            onChanged: (_) => scope.engagementController
                                .toggleChallengeTask(challenge.id, taskIndex),
                            title: Text(task.title),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
