import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/skin_metric.dart';
import '../../main.dart';

class SkinHealthScreen extends StatelessWidget {
  const SkinHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    final controller = scope.engagementController;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('skin_health'))),
      body: ValueListenableBuilder(
        valueListenable: controller.skinMetrics,
        builder: (_, List<SkinMetric> metrics, __) {
          if (metrics.isEmpty) {
            return Center(child: Text(loc.t('no_metrics')));
          }
          final sorted = [...metrics]
            ..sort((a, b) => b.date.compareTo(a.date));
          final hydrationAvg =
              sorted.map((m) => m.hydration).reduce((a, b) => a + b) /
                  sorted.length;
          final radianceAvg =
              sorted.map((m) => m.radiance).reduce((a, b) => a + b) /
                  sorted.length;
          final breakoutAvg = sorted
                  .map((m) => m.breakouts)
                  .reduce((a, b) => a + b) /
              sorted.length;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(loc.t('trend_hint'),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).hintColor)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _MetricCard(
                    title: loc.t('hydration'),
                    value: '${(hydrationAvg * 100).round()}%',
                    color: Colors.blueAccent,
                  ),
                  _MetricCard(
                    title: loc.t('radiance'),
                    value: '${(radianceAvg * 100).round()}%',
                    color: Colors.orangeAccent,
                  ),
                  _MetricCard(
                    title: loc.t('breakouts'),
                    value: breakoutAvg.toStringAsFixed(1),
                    color: Colors.pinkAccent,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(loc.t('recent_notes'),
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...sorted.take(6).map((m) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(
                      m.note,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      '${m.formatDate(context)} • ${loc.t('hydration')}: ${(m.hydration * 100).round()}% | ${loc.t('radiance')}: ${(m.radiance * 100).round()}% | ${loc.t('breakouts')}: ${m.breakouts}',
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  final hydration = (sorted.first.hydration + 0.04).clamp(0.5, 0.95);
                  final radiance = (sorted.first.radiance + 0.03).clamp(0.5, 0.95);
                  final entry = SkinMetric(
                    date: DateTime.now(),
                    hydration: hydration,
                    radiance: radiance,
                    breakouts: sorted.first.breakouts > 0
                        ? sorted.first.breakouts - 1
                        : 0,
                    note: loc.t('log_entry'),
                  );
                  controller.logSkinMetric(entry);
                },
                icon: const Icon(Icons.add_chart),
                label: Text(loc.t('log_today')),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const _MetricCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

