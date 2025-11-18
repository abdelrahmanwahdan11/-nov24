import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType keyboardType;

  const AppTextField({super.key, required this.controller, required this.hint, this.obscure = false, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Theme.of(context).cardColor.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 400)).slideY(begin: 0.2, end: 0);
  }
}
