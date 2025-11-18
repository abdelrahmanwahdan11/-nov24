import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';
import '../../core/models/wellness_plan.dart';

class RoutineCalendarScreen extends StatelessWidget {
  const RoutineCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('routine_calendar'))),
      body: ValueListenableBuilder<List<WellnessPlanDay>>(
        valueListenable: scope.engagementController.carePlan,
        builder: (_, plan, __) {
          return ValueListenableBuilder<Set<String>>(
            valueListenable: scope.engagementController.completedPlanDays,
            builder: (_, completedDays, __) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: plan.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final day = plan[index];
                  final isDone = completedDays.contains(day.id);
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(day.dayLabel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  Text(day.focus,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                              FilledButton.tonal(
                                onPressed: () => scope.engagementController
                                    .togglePlanDay(day.id),
                                child: Text(isDone
                                    ? loc.t('day_done')
                                    : loc.t('mark_day_done')),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(day.tip),
                          const SizedBox(height: 8),
                          ...day.tasks.asMap().entries.map((entry) {
                            final task = entry.value;
                            return CheckboxListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              value: task.completed,
                              onChanged: (_) => scope.engagementController
                                  .togglePlanTask(day.id, entry.key),
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
          );
        },
      ),
    );
  }
}
