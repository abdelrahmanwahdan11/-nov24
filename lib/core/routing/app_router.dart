import 'package:flutter/material.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/root_shell/root_shell.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/product_details/product_details_screen.dart';
import '../../features/comparison/comparison_screen.dart';

class AppRouter {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgot = '/forgot';
  static const root = '/root';
  static const productDetails = '/product';
  static const compare = '/compare';

  static Route<dynamic>? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgot:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case root:
        return MaterialPageRoute(builder: (_) => const RootShell());
      case productDetails:
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: settings.arguments),
        );
      case compare:
        return MaterialPageRoute(builder: (_) => const ComparisonScreen());
      default:
        return null;
    }
  }
}
