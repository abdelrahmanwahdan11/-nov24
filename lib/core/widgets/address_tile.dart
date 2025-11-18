import 'package:flutter/material.dart';
import '../models/address.dart';

class AddressTile extends StatelessWidget {
  final Address address;
  final bool selected;
  final VoidCallback onTap;
  const AddressTile({super.key, required this.address, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(address.mapImageUrl, width: 56, height: 56, fit: BoxFit.cover),
      ),
      title: Text(address.title),
      subtitle: Text(address.subtitle),
      trailing: selected ? const Icon(Icons.check_circle, color: Colors.green) : null,
      onTap: onTap,
    );
  }
}
