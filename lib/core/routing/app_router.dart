import 'package:flutter/material.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/root_shell/root_shell.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/product_details/product_details_screen.dart';
import '../../features/comparison/comparison_screen.dart';
import '../../features/profile/rewards_screen.dart';
import '../../features/profile/notifications_screen.dart';
import '../../features/profile/address_book_screen.dart';
import '../../features/profile/skin_quiz_screen.dart';
import '../../features/profile/routine_planner_screen.dart';
import '../../features/profile/order_details_screen.dart';
import '../models/order.dart';

class AppRouter {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgot = '/forgot';
  static const root = '/root';
  static const productDetails = '/product';
  static const compare = '/compare';
  static const rewards = '/rewards';
  static const notifications = '/notifications';
  static const addresses = '/addresses';
  static const quiz = '/quiz';
  static const routine = '/routine';
  static const orderDetails = '/order-details';

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
      case rewards:
        return MaterialPageRoute(builder: (_) => const RewardsScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case addresses:
        return MaterialPageRoute(builder: (_) => const AddressBookScreen());
      case quiz:
        return MaterialPageRoute(builder: (_) => const SkinQuizScreen());
      case routine:
        return MaterialPageRoute(builder: (_) => const RoutinePlannerScreen());
      case orderDetails:
        return MaterialPageRoute(
          builder: (_) => OrderDetailsScreen(order: settings.arguments as Order),
        );
      default:
        return null;
    }
  }
}
