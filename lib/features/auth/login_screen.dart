import 'package:flutter/material.dart';
import '../../core/controllers/auth_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/routing/app_router.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final auth = AppScope.of(context).authController;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('login'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(controller: emailController, hint: 'Email or phone'),
            const SizedBox(height: 12),
            AppTextField(
              controller: passwordController,
              hint: 'Password',
              obscure: obscure,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRouter.forgot),
                child: const Text('Forgot?'),
              ),
            ),
            const SizedBox(height: 12),
            AppButton(
              label: loading ? '...' : loc.t('login'),
              onPressed: loading
                  ? () {}
                  : () async {
                      setState(() => loading = true);
                      await auth.login(emailController.text, passwordController.text);
                      if (!mounted) return;
                      Navigator.pushReplacementNamed(context, AppRouter.root);
                    },
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.register),
              child: Text(loc.t('register')),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.root),
              child: Text(loc.t('continue_guest')),
            ),
          ],
        ),
      ),
    );
  }
}
