import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class RecallAlertsScreen extends StatelessWidget {
  const RecallAlertsScreen({super.key});

  Color _severityColor(String severity, BuildContext context) {
    switch (severity) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('recall_center'))),
      body: ValueListenableBuilder(
        valueListenable: scope.engagementController.recallAlerts,
        builder: (_, alerts, __) {
          if (alerts.isEmpty) {
            return Center(child: Text(loc.t('no_recalls')));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final alert = alerts[index];
              final severityColor = _severityColor(alert.severity, context);
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(alert.imageUrl, width: 64, height: 64, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(alert.productName, style: Theme.of(context).textTheme.titleMedium),
                                Text('${loc.t('lot_code')} ${alert.lotCode}',
                                    style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: severityColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(alert.severity.toUpperCase(), style: TextStyle(color: severityColor)),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(alert.issue, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      Text(alert.action, style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 8),
                      Text(loc.t('expires_on', params: {'date': _dateLabel(alert.expiresAt)}),
                          style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(alert.acknowledged ? Icons.check_circle : Icons.warning_amber_rounded,
                              color: alert.acknowledged ? Colors.green : severityColor),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(alert.acknowledged
                                ? loc.t('acknowledged')
                                : loc.t('acknowledge_hint')),
                          ),
                          if (!alert.acknowledged)
                            TextButton(
                              onPressed: () => scope.engagementController.acknowledgeRecall(alert.id),
                              child: Text(loc.t('mark_acknowledged')),
                            )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: alerts.length,
          );
        },
      ),
    );
  }

  String _dateLabel(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
