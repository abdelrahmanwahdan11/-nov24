import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';
import '../../core/models/skin_diary_entry.dart';

class SkinDiaryScreen extends StatefulWidget {
  const SkinDiaryScreen({super.key});

  @override
  State<SkinDiaryScreen> createState() => _SkinDiaryScreenState();
}

class _SkinDiaryScreenState extends State<SkinDiaryScreen> {
  final TextEditingController _noteController = TextEditingController();
  String _selectedMood = 'Calm';

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final engagement = AppScope.of(context).engagementController;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('skin_diary'))),
      body: ValueListenableBuilder<List<SkinDiaryEntry>>(
        valueListenable: engagement.diaryEntries,
        builder: (_, entries, __) {
          if (entries.isEmpty) {
            return Center(child: Text(loc.t('no_entries')));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, index) {
              final entry = entries[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text(entry.mood),
                  subtitle: Text(entry.note),
                  trailing: Text('${entry.date.month}/${entry.date.day}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEntry(context),
        label: Text(loc.t('add_entry')),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showAddEntry(BuildContext context) {
    final loc = AppLocalizations.of(context);
    _noteController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loc.t('add_entry'), style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(loc.t('mood')),
              Wrap(
                spacing: 8,
                children: ['Calm', 'Glowing', 'Sensitive', 'Oily'].map((mood) {
                  return ChoiceChip(
                    label: Text(mood),
                    selected: _selectedMood == mood,
                    onSelected: (_) => setState(() => _selectedMood = mood),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: loc.t('entry_hint'),
                  labelText: loc.t('note'),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    AppScope.of(context)
                        .engagementController
                        .addDiaryEntry(_selectedMood, _noteController.text);
                    Navigator.pop(context);
                  },
                  child: Text(loc.t('save')),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
