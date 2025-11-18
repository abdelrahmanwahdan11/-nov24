import 'package:flutter/material.dart';
import '../../core/controllers/auth_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/routing/app_router.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final auth = AppScope.of(context).authController;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('register'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppTextField(controller: nameController, hint: 'Full name'),
            const SizedBox(height: 12),
            AppTextField(controller: emailController, hint: 'Email'),
            const SizedBox(height: 12),
            AppTextField(controller: passwordController, hint: 'Password', obscure: true),
            const SizedBox(height: 12),
            AppTextField(controller: confirmController, hint: 'Confirm password', obscure: true),
            const SizedBox(height: 16),
            LinearProgressIndicator(value: _strength(passwordController.text)),
            const SizedBox(height: 12),
            AppButton(
              label: loading ? '...' : loc.t('register'),
              onPressed: loading
                  ? () {}
                  : () async {
                      if (passwordController.text != confirmController.text) return;
                      setState(() => loading = true);
                      await auth.register(nameController.text, emailController.text, passwordController.text);
                      if (!mounted) return;
                      Navigator.pushReplacementNamed(context, AppRouter.root);
                    },
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.login),
              child: Text(loc.t('login')),
            ),
          ],
        ),
      ),
    );
  }

  double _strength(String password) {
    double strength = 0;
    if (password.length > 6) strength += 0.3;
    if (password.length > 10) strength += 0.3;
    if (RegExp(r"[A-Z]").hasMatch(password)) strength += 0.2;
    if (RegExp(r"[0-9]").hasMatch(password)) strength += 0.2;
    return strength.clamp(0, 1);
  }
}
