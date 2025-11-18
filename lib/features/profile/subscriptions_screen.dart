import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  String _formatDate(DateTime date) {
    return date.toLocal().toString().split(' ').first;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('subscriptions'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: scope.engagementController.subscriptions,
          builder: (_, plans, __) {
            if (plans.isEmpty) {
              return Center(child: Text(loc.t('empty_subscriptions')));
            }
            return ListView.separated(
              itemCount: plans.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final plan = plans[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(plan.imageUrl, width: 72, height: 72, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(plan.title, style: Theme.of(context).textTheme.titleMedium),
                              Text(plan.productName, style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 6),
                              Text('${loc.t('frequency')}: ${plan.frequency}'),
                              Text('${loc.t('next_delivery')}: ${_formatDate(plan.nextDelivery)}'),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  OutlinedButton(
                                    onPressed: () => scope.engagementController.changeFrequency(plan.id),
                                    child: Text(loc.t('adjust_frequency')),
                                  ),
                                  OutlinedButton(
                                    onPressed: () => scope.engagementController.skipNextDelivery(plan.id),
                                    child: Text(loc.t('skip_next')),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Switch(
                              value: !plan.paused,
                              onChanged: (_) => scope.engagementController.toggleSubscriptionPause(plan.id),
                            ),
                            const SizedBox(height: 4),
                            Text(plan.paused ? loc.t('resume') : loc.t('pause')),
                            const SizedBox(height: 8),
                            Chip(label: Text('${loc.t('currency')} ${plan.price.toStringAsFixed(0)}')),
                          ],
                        ),
                      ],
                    ),
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
