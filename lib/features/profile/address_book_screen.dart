import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/address_tile.dart';
import '../../core/models/address.dart';
import '../../main.dart';

class AddressBookScreen extends StatefulWidget {
  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('addresses'))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddDialog(scope, loc),
        icon: const Icon(Icons.add_location_alt_outlined),
        label: Text(loc.t('add_address')),
      ),
      body: ValueListenableBuilder(
        valueListenable: scope.engagementController.addresses,
        builder: (_, list, __) {
          if (list.isEmpty) {
            return Center(child: Text(loc.t('no_addresses')));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) => AddressTile(address: list[index]),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: list.length,
          );
        },
      ),
    );
  }

  Future<void> _openAddDialog(AppScope scope, AppLocalizations loc) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(loc.t('add_address')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: loc.t('label')), 
              ),
              TextField(
                controller: _subtitleController,
                decoration: InputDecoration(labelText: loc.t('details')),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.t('cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                scope.engagementController.addAddress(
                  Address(
                    title: _titleController.text.isEmpty
                        ? loc.t('new_address')
                        : _titleController.text,
                    subtitle: _subtitleController.text,
                    mapImageUrl:
                        'https://images.pexels.com/photos/1115804/pexels-photo-1115804.jpeg?auto=compress&cs=tinysrgb&w=800',
                  ),
                );
                _titleController.clear();
                _subtitleController.clear();
                Navigator.pop(context);
              },
              child: Text(loc.t('save')),
            ),
          ],
        );
      },
    );
  }
}
