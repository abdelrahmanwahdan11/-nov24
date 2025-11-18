import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  const QuantitySelector({super.key, required this.value, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove_circle_outline)),
        Text('$value'),
        IconButton(onPressed: onIncrement, icon: const Icon(Icons.add_circle_outline)),
      ],
    );
  }
}
