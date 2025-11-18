import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';
import '../../core/models/shelf_product.dart';

class ShelfLifeScreen extends StatelessWidget {
  const ShelfLifeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('shelf_life'))),
      body: ValueListenableBuilder(
        valueListenable: scope.engagementController.shelfProducts,
        builder: (_, items, __) {
          final list = items as List<ShelfProduct>;
          if (list.isEmpty) {
            return Center(
              child: Text(loc.t('shelf_empty'),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).hintColor)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
              final item = list[index];
              return _ShelfCard(item: item, scope: scope, loc: loc);
            },
          );
        },
      ),
    );
  }
}

class _ShelfCard extends StatelessWidget {
  final ShelfProduct item;
  final AppScope scope;
  final AppLocalizations loc;
  const _ShelfCard({required this.item, required this.scope, required this.loc});

  int _daysLeft() {
    final total = item.shelfLifeMonths * 30;
    final elapsed = DateTime.now().difference(item.openedAt).inDays;
    return (total - elapsed).clamp(-total, total);
  }

  double _progress() {
    final total = (item.shelfLifeMonths * 30).toDouble();
    final elapsed = DateTime.now().difference(item.openedAt).inDays.toDouble();
    if (total <= 0) return 1;
    return (elapsed / total).clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final daysLeft = _daysLeft();
    final expired = daysLeft <= 0 || item.isFinished;
    final daysLabel = loc.t('days_left_value').replaceFirst('{d}', daysLeft.toString());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(item.imageUrl, width: 72, height: 72, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: Theme.of(context).textTheme.titleMedium),
                      Text(item.category,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Theme.of(context).hintColor)),
                      const SizedBox(height: 4),
                      Text(item.note, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Chip(
                      label: Text(item.isFinished ? loc.t('finished') : (item.isOpen ? loc.t('open_now') : loc.t('not_opened'))),
                    ),
                    Text(daysLabel, style: Theme.of(context).textTheme.bodySmall),
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: _progress()),
            const SizedBox(height: 8),
            Text(
              expired ? loc.t('expired') : loc.t('shelf_progress_hint'),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: expired ? Theme.of(context).colorScheme.error : Theme.of(context).hintColor),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                TextButton.icon(
                  onPressed: () => scope.engagementController.toggleShelfOpen(item.id),
                  icon: const Icon(Icons.restart_alt),
                  label: Text(item.isOpen ? loc.t('refresh_open_date') : loc.t('mark_opened')),
                ),
                TextButton.icon(
                  onPressed: () => scope.engagementController.toggleShelfFinished(item.id),
                  icon: Icon(item.isFinished ? Icons.undo : Icons.check_circle_outline),
                  label: Text(item.isFinished ? loc.t('reopen_item') : loc.t('mark_finished')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
