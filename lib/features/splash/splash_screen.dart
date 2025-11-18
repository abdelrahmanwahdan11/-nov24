import 'package:flutter/material.dart';
import '../../core/controllers/onboarding_controller.dart';
import '../../core/controllers/auth_controller.dart';
import '../../core/routing/app_router.dart';
import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late OnboardingController onboardingController;
  late AuthController authController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = AppScope.of(context);
    onboardingController = OnboardingController();
    authController = scope.authController;
    _decide();
  }

  Future<void> _decide() async {
    final seen = await onboardingController.hasSeen();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    if (!seen) {
      Navigator.of(context).pushReplacementNamed(AppRouter.onboarding);
    } else if (authController.user.value != null) {
      Navigator.of(context).pushReplacementNamed(AppRouter.root);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
