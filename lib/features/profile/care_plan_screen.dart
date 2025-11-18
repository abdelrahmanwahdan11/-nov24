import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/wellness_plan.dart';
import '../../main.dart';

class CarePlanScreen extends StatelessWidget {
  const CarePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('care_plan'))),
      body: ValueListenableBuilder<List<WellnessPlanDay>>(
        valueListenable: scope.engagementController.carePlan,
        builder: (_, days, __) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(loc.t('weekly_plan_hint')),
              const SizedBox(height: 12),
              ...days.map((day) {
                final completed = day.completedCount;
                final total = day.tasks.length;
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      child: Text(day.dayLabel.substring(0, 2)),
                    ),
                    title: Text(day.dayLabel),
                    subtitle: Text('${loc.t('focus')}: ${day.focus}'),
                    trailing: Chip(label: Text('$completed/$total')),
                    children: [
                      ...day.tasks.asMap().entries.map((entry) {
                        return CheckboxListTile(
                          value: entry.value.completed,
                          onChanged: (_) =>
                              scope.engagementController.togglePlanTask(day.id, entry.key),
                          title: Text(entry.value.title),
                        );
                      }).toList(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Row(
                          children: [
                            const Icon(Icons.tips_and_updates_outlined),
                            const SizedBox(width: 8),
                            Expanded(child: Text('${loc.t('coach_tip')}: ${day.tip}')),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: scope.engagementController.resetPlanProgress,
                icon: const Icon(Icons.refresh),
                label: Text(loc.t('reset_progress')),
              )
            ],
          );
        },
      ),
    );
  }
}
