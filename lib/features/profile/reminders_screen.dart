import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    final controller = scope.engagementController;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('reminders'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.t('reminder_note'),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).hintColor),
            ),
            const SizedBox(height: 16),
            _ReminderTile(
              title: loc.t('morning_reminder'),
              enabledListenable: controller.morningReminderEnabled,
              timeListenable: controller.morningReminderTime,
              onToggle: (value) =>
                  controller.toggleReminder(morning: true, enabled: value),
              onPick: (time) =>
                  controller.updateReminderTime(morning: true, time: time),
            ),
            const SizedBox(height: 12),
            _ReminderTile(
              title: loc.t('evening_reminder'),
              enabledListenable: controller.eveningReminderEnabled,
              timeListenable: controller.eveningReminderTime,
              onToggle: (value) =>
                  controller.toggleReminder(morning: false, enabled: value),
              onPick: (time) =>
                  controller.updateReminderTime(morning: false, time: time),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  final String title;
  final ValueNotifier<bool> enabledListenable;
  final ValueNotifier<TimeOfDay> timeListenable;
  final ValueChanged<bool> onToggle;
  final ValueChanged<TimeOfDay> onPick;
  const _ReminderTile({
    required this.title,
    required this.enabledListenable,
    required this.timeListenable,
    required this.onToggle,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: ValueListenableBuilder(
          valueListenable: enabledListenable,
          builder: (_, enabled, __) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6),
                      ValueListenableBuilder(
                        valueListenable: timeListenable,
                        builder: (_, time, __) {
                          final timeLabel = MaterialLocalizations.of(context)
                              .formatTimeOfDay(time, alwaysUse24HourFormat: false);
                          return Text(
                            '${loc.t('reminder_time')}: $timeLabel',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Theme.of(context).hintColor),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: enabled
                            ? () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: timeListenable.value,
                                );
                                if (picked != null) onPick(picked);
                              }
                            : null,
                        child: Text(loc.t('update_time')),
                      ),
                    ],
                  ),
                ),
                Switch(value: enabled, onChanged: onToggle),
              ],
            );
          },
        ),
      ),
    );
  }
}

