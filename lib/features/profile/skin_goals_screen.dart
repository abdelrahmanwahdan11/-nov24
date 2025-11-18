import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class SkinGoalsScreen extends StatelessWidget {
  const SkinGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('skin_goals'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: scope.engagementController.goals,
          builder: (_, goals, __) {
            if (goals.isEmpty) {
              return Center(child: Text(loc.t('no_goals')));
            }
            return ListView.separated(
              itemCount: goals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final goal = goals[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(goal.title,
                                  style: Theme.of(context).textTheme.titleMedium),
                            ),
                            Text('${(goal.progress * 100).round()}%',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(goal.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Theme.of(context).hintColor)),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(value: goal.progress),
                        const SizedBox(height: 8),
                        Text(loc.t('goal_actions'),
                            style: Theme.of(context).textTheme.titleSmall),
                        ...List.generate(goal.tasks.length, (taskIndex) {
                          final task = goal.tasks[taskIndex];
                          return CheckboxListTile(
                            value: task.done,
                            onChanged: (_) => scope.engagementController
                                .toggleGoalStep(goal.id, taskIndex),
                            title: Text(task.title),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
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
