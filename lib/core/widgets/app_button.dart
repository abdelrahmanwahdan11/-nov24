import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool expanded;

  const AppButton({super.key, required this.label, required this.onPressed, this.expanded = true});

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      ),
      child: Text(label),
    ).animate().scale(duration: const Duration(milliseconds: 400), curve: Curves.easeOutBack);

    if (expanded) {
      return SizedBox(width: double.infinity, child: btn);
    }
    return btn;
  }
}
