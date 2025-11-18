import 'package:flutter/material.dart';

class ChipFilter extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ChipFilter({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );
  }
}
