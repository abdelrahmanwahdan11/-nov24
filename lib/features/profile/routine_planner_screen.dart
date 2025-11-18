import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/routine_step.dart';
import '../../main.dart';

class RoutinePlannerScreen extends StatelessWidget {
  const RoutinePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('routine_planner'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(loc.t('morning'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...scope.engagementController.morningRoutine
              .map((step) => _RoutineCard(step: step))
              .toList(),
          const SizedBox(height: 24),
          Text(loc.t('evening'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...scope.engagementController.eveningRoutine
              .map((step) => _RoutineCard(step: step))
              .toList(),
        ],
      ),
    );
  }
}

class _RoutineCard extends StatelessWidget {
  final RoutineStep step;
  const _RoutineCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(step.icon),
        title: Text(step.title),
        subtitle: Text(step.subtitle),
        trailing: step.waitTime != null
            ? Chip(label: Text('~${step.waitTime!.inMinutes} min'))
            : null,
      ),
    );
  }
}
