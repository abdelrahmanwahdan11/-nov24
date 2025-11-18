import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';

class SosPlaybookScreen extends StatefulWidget {
  const SosPlaybookScreen({super.key});

  @override
  State<SosPlaybookScreen> createState() => _SosPlaybookScreenState();
}

class _SosPlaybookScreenState extends State<SosPlaybookScreen> {
  final List<_SosCard> _cards = [
    _SosCard(
      keyId: 'breakout',
      titleKey: 'sos_breakout_title',
      subtitleKey: 'sos_breakout_sub',
      steps: [
        'sos_breakout_step_cleanse',
        'sos_breakout_step_spot',
        'sos_breakout_step_moist',
      ],
    ),
    _SosCard(
      keyId: 'sunburn',
      titleKey: 'sos_sunburn_title',
      subtitleKey: 'sos_sunburn_sub',
      steps: [
        'sos_sunburn_step_cool',
        'sos_sunburn_step_avoid',
        'sos_sunburn_step_sleep',
      ],
    ),
    _SosCard(
      keyId: 'dryness',
      titleKey: 'sos_dryness_title',
      subtitleKey: 'sos_dryness_sub',
      steps: [
        'sos_dryness_step_mist',
        'sos_dryness_step_layer',
        'sos_dryness_step_lock',
      ],
    ),
  ];

  final Map<String, Set<int>> _completed = {};

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('sos_playbook'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(loc.t('sos_intro'), style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          ..._cards.map((card) => _buildCard(card, loc)),
        ],
      ),
    );
  }

  Widget _buildCard(_SosCard card, AppLocalizations loc) {
    final doneSteps = _completed[card.keyId] ?? {};
    final progress = doneSteps.length / card.steps.length;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.t(card.titleKey),
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(loc.t(card.subtitleKey),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                IconButton(
                  onPressed: () => setState(() => _completed.remove(card.keyId)),
                  icon: const Icon(Icons.refresh),
                )
              ],
            ),
            const SizedBox(height: 8),
            ...card.steps.asMap().entries.map((entry) {
              final idx = entry.key;
              final stepKey = entry.value;
              final isDone = doneSteps.contains(idx);
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Checkbox(
                  value: isDone,
                  onChanged: (_) => setState(() {
                    final set = {...doneSteps};
                    if (isDone) {
                      set.remove(idx);
                    } else {
                      set.add(idx);
                    }
                    _completed[card.keyId] = set;
                  }),
                ),
                title: Text(loc.t(stepKey)),
                subtitle: Text(loc.t('sos_step_hint')),
              );
            }),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 4),
            Text(loc.t('sos_progress', params: {'value': (progress * 100).toStringAsFixed(0)})),
          ],
        ),
      ),
    );
  }
}

class _SosCard {
  final String keyId;
  final String titleKey;
  final String subtitleKey;
  final List<String> steps;

  const _SosCard({
    required this.keyId,
    required this.titleKey,
    required this.subtitleKey,
    required this.steps,
  });
}
