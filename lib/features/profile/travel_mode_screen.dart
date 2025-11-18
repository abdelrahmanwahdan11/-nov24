import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class TravelModeScreen extends StatelessWidget {
  const TravelModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    final climates = [
      'Dry cabin · pack humectants',
      'Humid coast · go gel-light',
      'Cold city · bring balm',
      'Sunny desert · SPF stick + hat',
    ];
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('travel_mode'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.t('travel_mode_hint'),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).hintColor)),
            const SizedBox(height: 12),
            Text(loc.t('select_climate'),
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: scope.engagementController.travelClimate,
              builder: (_, selected, __) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: climates
                      .map(
                        (label) => ChoiceChip(
                          label: Text(label),
                          selected: selected == label,
                          onSelected: (_) =>
                              scope.engagementController.setTravelClimate(label),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(loc.t('travel_packlist'),
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: scope.engagementController.travelKit,
                builder: (_, items, __) {
                  return ListView.separated(
                    itemBuilder: (_, index) {
                      final item = items[index];
                      return CheckboxListTile(
                        title: Text(item.title),
                        subtitle: Text(item.subtitle),
                        value: item.packed,
                        onChanged: (_) =>
                            scope.engagementController.toggleTravelItem(item.id),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemCount: items.length,
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: scope.engagementController.travelKit,
              builder: (_, items, __) {
                final packedCount = items.where((e) => e.packed).length;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${loc.t('packed_ready')} $packedCount/${items.length}'),
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(loc.t('save_checklist')),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
