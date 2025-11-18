import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';
import '../../core/models/tracking_event.dart';

class WellnessTimelineScreen extends StatelessWidget {
  const WellnessTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('wellness_timeline'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<List<TrackingEvent>>(
          valueListenable: scope.engagementController.timelineEvents,
          builder: (_, events, __) {
            if (events.isEmpty) {
              return Center(child: Text(loc.t('no_timeline')));
            }
            return ListView.separated(
              itemCount: events.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final event = events[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: Icon(
                      event.isDone
                          ? Icons.check_circle_rounded
                          : Icons.brightness_1_outlined,
                      color: event.isDone
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).iconTheme.color,
                    ),
                    title: Text(event.title),
                    subtitle: Text(event.detail),
                    trailing: Text(event.timestamp),
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
