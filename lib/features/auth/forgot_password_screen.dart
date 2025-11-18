import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('forgot_password'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Reset link sent to ${emailController.text}')));
              },
              child: const Text('Send'),
            )
          ],
        ),
      ),
    );
  }
}
