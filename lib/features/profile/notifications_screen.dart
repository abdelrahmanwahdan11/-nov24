import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.t('notifications')),
        actions: [
          TextButton(
            onPressed: scope.engagementController.markAllRead,
            child: Text(loc.t('mark_all')),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: scope.engagementController.notifications,
        builder: (_, list, __) {
          if (list.isEmpty) {
            return Center(child: Text(loc.t('no_notifications')));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final item = list[index];
              return Card(
                color: item.isRead
                    ? Theme.of(context).cardColor
                    : Theme.of(context).colorScheme.primary.withOpacity(0.06),
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.body),
                      const SizedBox(height: 4),
                      Text(
                        '${item.date.month}/${item.date.day} ${item.date.hour.toString().padLeft(2, '0')}:${item.date.minute.toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: item.isRead
                      ? const Icon(Icons.check, size: 18)
                      : IconButton(
                          icon: const Icon(Icons.mark_email_read_outlined),
                          onPressed: () =>
                              scope.engagementController.markNotificationRead(item.id),
                        ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: list.length,
          );
        },
      ),
    );
  }
}
