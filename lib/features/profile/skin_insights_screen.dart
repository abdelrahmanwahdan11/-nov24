import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/app_skeleton.dart';
import '../../core/models/skin_metric.dart';

class SkinInsightsScreen extends StatelessWidget {
  const SkinInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('skin_insights'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<List<SkinMetric>>(
          valueListenable: scope.engagementController.skinMetrics,
          builder: (_, metrics, __) {
            if (metrics.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: loc.t('trend_week')),
                  const SizedBox(height: 12),
                  AppSkeleton(height: 120, width: double.infinity),
                  const SizedBox(height: 12),
                  AppSkeleton(height: 80, width: double.infinity),
                ],
              );
            }
            final averages = scope.engagementController.weeklySkinAverages();
            final insights = scope.engagementController.deriveInsights();
            return ListView(
              children: [
                SectionHeader(title: loc.t('trend_week')),
                const SizedBox(height: 12),
                _MetricCard(
                  title: loc.t('hydration_avg'),
                  value: averages['hydration'] ?? 0,
                  accent: Colors.teal,
                ),
                _MetricCard(
                  title: loc.t('radiance_avg'),
                  value: averages['radiance'] ?? 0,
                  accent: Colors.amber,
                ),
                _MetricCard(
                  title: loc.t('breakouts_avg'),
                  value: 1 - ((averages['breakouts'] ?? 0) / 5).clamp(0.0, 1.0),
                  accent: Colors.pinkAccent,
                  inverted: true,
                ),
                const SizedBox(height: 16),
                SectionHeader(title: loc.t('latest_checkins')),
                const SizedBox(height: 8),
                ...metrics.take(4).map((m) => _CheckInTile(metric: m)),
                const SizedBox(height: 16),
                SectionHeader(title: loc.t('insight_tips')),
                const SizedBox(height: 8),
                if (insights.isEmpty)
                  Text(loc.t('no_insights_yet'))
                else
                  ...insights
                      .map((tip) => Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: const Icon(Icons.auto_awesome_rounded),
                              title: Text(tip),
                            ),
                          ))
                      .toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.accent,
    this.inverted = false,
  });

  final String title;
  final double value;
  final Color accent;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: inverted ? clamped : clamped,
              minHeight: 10,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
            const SizedBox(height: 8),
            Text('${(clamped * 100).toStringAsFixed(0)}%'),
          ],
        ),
      ),
    );
  }
}

class _CheckInTile extends StatelessWidget {
  const _CheckInTile({required this.metric});

  final SkinMetric metric;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.monitor_heart_outlined),
        title: Text(
            '${(metric.hydration * 100).toStringAsFixed(0)}% · ${(metric.radiance * 100).toStringAsFixed(0)}%'),
        subtitle: Text(metric.note),
        trailing: Text('${metric.date.month}/${metric.date.day}'),
      ),
    );
  }
}
