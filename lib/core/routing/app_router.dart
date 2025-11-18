import 'package:flutter/material.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/root_shell/root_shell.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/product_details/product_details_screen.dart';
import '../../features/comparison/comparison_screen.dart';
import '../../features/cart/checkout_screen.dart';
import '../../features/profile/rewards_screen.dart';
import '../../features/profile/notifications_screen.dart';
import '../../features/profile/address_book_screen.dart';
import '../../features/profile/skin_quiz_screen.dart';
import '../../features/profile/routine_planner_screen.dart';
import '../../features/profile/order_details_screen.dart';
import '../../features/profile/glow_journal_screen.dart';
import '../../features/profile/article_detail_screen.dart';
import '../../features/profile/skin_diary_screen.dart';
import '../../features/profile/consultation_screen.dart';
import '../../features/profile/order_tracking_screen.dart';
import '../../features/profile/skin_goals_screen.dart';
import '../../features/profile/challenges_screen.dart';
import '../../features/profile/referrals_screen.dart';
import '../../features/profile/skin_report_screen.dart';
import '../../features/profile/subscriptions_screen.dart';
import '../../features/profile/coupon_center_screen.dart';
import '../../features/profile/wellness_dashboard_screen.dart';
import '../../features/search/search_overlay.dart';
import '../../features/catalog/bundles_screen.dart';
import '../models/order.dart';
import '../models/article.dart';

class AppRouter {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgot = '/forgot';
  static const root = '/root';
  static const productDetails = '/product';
  static const compare = '/compare';
  static const checkout = '/checkout';
  static const rewards = '/rewards';
  static const notifications = '/notifications';
  static const addresses = '/addresses';
  static const quiz = '/quiz';
  static const routine = '/routine';
  static const orderDetails = '/order-details';
  static const journal = '/journal';
  static const articleDetails = '/article';
  static const diary = '/diary';
  static const consultation = '/consultation';
  static const search = '/search';
  static const trackOrder = '/track-order';
  static const bundles = '/bundles';
  static const goals = '/goals';
  static const challenges = '/challenges';
  static const referrals = '/referrals';
  static const subscriptions = '/subscriptions';
  static const skinReport = '/skin-report';
  static const couponCenter = '/coupon-center';
  static const wellnessDashboard = '/wellness-dashboard';

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
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
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
      case journal:
        return MaterialPageRoute(builder: (_) => const GlowJournalScreen());
      case articleDetails:
        return MaterialPageRoute(
          builder: (_) => ArticleDetailScreen(article: settings.arguments as Article),
        );
      case diary:
        return MaterialPageRoute(builder: (_) => const SkinDiaryScreen());
      case consultation:
        return MaterialPageRoute(builder: (_) => const ConsultationScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchOverlay());
      case trackOrder:
        return MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(order: settings.arguments as Order),
        );
      case bundles:
        return MaterialPageRoute(builder: (_) => const BundlesScreen());
      case goals:
        return MaterialPageRoute(builder: (_) => const SkinGoalsScreen());
      case challenges:
        return MaterialPageRoute(builder: (_) => const ChallengesScreen());
      case referrals:
        return MaterialPageRoute(builder: (_) => const ReferralsScreen());
      case subscriptions:
        return MaterialPageRoute(builder: (_) => const SubscriptionsScreen());
      case skinReport:
        return MaterialPageRoute(builder: (_) => const SkinReportScreen());
      case couponCenter:
        return MaterialPageRoute(builder: (_) => const CouponCenterScreen());
      case wellnessDashboard:
        return MaterialPageRoute(builder: (_) => const WellnessDashboardScreen());
      default:
        return null;
    }
  }
}
