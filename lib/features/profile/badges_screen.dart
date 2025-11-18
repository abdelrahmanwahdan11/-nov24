import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('badge_wall'))),
      body: ValueListenableBuilder(
        valueListenable: scope.engagementController.badges,
        builder: (_, badges, __) {
          if (badges.isEmpty) {
            return Center(child: Text(loc.t('no_badges')));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final badge = badges[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            foregroundColor: Theme.of(context).colorScheme.primary,
                            child: Icon(badge.achieved ? Icons.emoji_events : Icons.star_border),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(badge.title, style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 4),
                                Text(badge.description,
                                    style: Theme.of(context).textTheme.bodySmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: badge.achieved
                                  ? Colors.green.withOpacity(0.1)
                                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              badge.achieved ? loc.t('badge_unlocked') : loc.t('in_progress'),
                              style: TextStyle(
                                color: badge.achieved ? Colors.green : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: badge.progress,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      const SizedBox(height: 8),
                      Text(loc.t('progress_label', params: {'value': '${(badge.progress * 100).round()}%'})),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: badges.length,
          );
        },
      ),
    );
  }
}
