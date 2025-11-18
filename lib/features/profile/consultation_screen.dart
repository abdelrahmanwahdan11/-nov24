import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final engagement = AppScope.of(context).engagementController;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('book_consultation'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.t('consultation_intro'), style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: engagement.nextConsultation,
              builder: (_, next, __) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  child: ListTile(
                    leading: const Icon(Icons.video_call_outlined),
                    title: Text(loc.t('next_session')),
                    subtitle: Text(next == null
                        ? loc.t('pick_slot')
                        : '${next.month}/${next.day} - ${next.hour}:00'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(loc.t('pick_slot'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: engagement.availableConsultations.map((slot) {
                final label = '${slot.month}/${slot.day}  ${slot.hour}:00';
                return ChoiceChip(
                  label: Text(label),
                  selected: engagement.nextConsultation.value == slot,
                  onSelected: (_) {
                    engagement.bookConsultation(slot);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.t('slot_booked'))),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
