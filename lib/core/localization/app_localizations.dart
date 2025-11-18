import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const _localizedStrings = {
    'en': {
      'app_name': 'Skin Glow',
      'skip': 'Skip',
      'next': 'Next',
      'login': 'Login',
      'register': 'Register',
      'continue_guest': 'Continue as guest',
      'forgot_password': 'Forgot password',
      'home': 'Home',
      'catalog': 'Catalog',
      'favorites': 'Favorites',
      'cart': 'Cart',
      'profile': 'Profile',
      'best_products': 'Our Best Product',
      'recommended': 'Recommended for you',
      'compare': 'Compare',
      'add_to_cart': 'Add to cart',
      'ai_info': 'AI info',
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
      'primary_color': 'Primary color',
      'dark_mode': 'Dark Mode',
      'pull_refresh': 'Pull to refresh',
      'empty_favorites': 'No favorites yet',
      'search': 'Search',
      'search_products': 'Search products',
      'checkout': 'Checkout',
      'pay_now': 'Pay now',
      'orders': 'My Orders',
      'help': 'Help Center',
      'about': 'About app',
      'ai_dialog': 'AI explanation coming soon',
      'no_items_compare': 'Add at least two products to compare.',
      'notifications': 'Notifications',
      'mark_all': 'Mark all',
      'no_notifications': 'Nothing new yet',
      'rewards': 'Rewards',
      'current_points': 'Current points',
      'next_tier_hint': 'Collect 360 more points to reach Rose Gold tier.',
      'perks': 'Perks you unlock',
      'perk_fast_shipping': 'Priority shipping on every order',
      'perk_skin_coach': '1:1 skin coach mini sessions',
      'perk_gifts': 'Surprise deluxe mini in monthly orders',
      'addresses': 'Addresses',
      'add_address': 'Add address',
      'no_addresses': 'No saved addresses yet',
      'label': 'Label',
      'details': 'Details',
      'cancel': 'Cancel',
      'save': 'Save',
      'new_address': 'New address',
      'skin_quiz': 'Skin quiz',
      'routine_planner': 'Routine planner',
      'morning': 'Morning',
      'evening': 'Evening',
      'see_recommendations': 'See recommendations',
      'quiz_result_title': 'Routine focus',
      'quiz_result_body': 'We recommend starting with',
      'close': 'Close',
      'order': 'Order',
      'status': 'Status',
      'delivery': 'Delivery',
      'payment_method': 'Payment method',
      'items': 'Items',
      'subtotal': 'Subtotal',
      'total': 'Total',
      'currency': 'USD',
      'guest': 'Guest',
      'logout': 'Logout',
      'address': 'Address',
      'wellness_hub': 'Glow Studio',
      'take_quiz': 'Take skin quiz',
      'plan_routine': 'Plan routine',
      'track_rewards': 'Track rewards',
    },
    'ar': {
      'app_name': 'توهج البشرة',
      'skip': 'تخطي',
      'next': 'التالي',
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'continue_guest': 'المتابعة كضيف',
      'forgot_password': 'نسيت كلمة المرور',
      'home': 'الرئيسية',
      'catalog': 'الكتالوج',
      'favorites': 'المفضلة',
      'cart': 'السلة',
      'profile': 'الحساب',
      'best_products': 'أفضل منتجاتنا',
      'recommended': 'مقترحة لك',
      'compare': 'مقارنة',
      'add_to_cart': 'أضف للسلة',
      'ai_info': 'معلومة بالذكاء الاصطناعي',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'theme': 'السمة',
      'primary_color': 'اللون الرئيسي',
      'dark_mode': 'الوضع الداكن',
      'pull_refresh': 'اسحب للتحديث',
      'empty_favorites': 'لا توجد مفضلة بعد',
      'search': 'بحث',
      'search_products': 'ابحث عن المنتجات',
      'checkout': 'الدفع',
      'pay_now': 'ادفع الآن',
      'orders': 'طلباتي',
      'help': 'مركز المساعدة',
      'about': 'حول التطبيق',
      'ai_dialog': 'شرح الذكاء الاصطناعي قريباً',
      'no_items_compare': 'أضف منتجين على الأقل للمقارنة.',
      'notifications': 'الإشعارات',
      'mark_all': 'تحديد الكل كمقروء',
      'no_notifications': 'لا جديد بعد',
      'rewards': 'المكافآت',
      'current_points': 'النقاط الحالية',
      'next_tier_hint': 'اجمع ٣٦٠ نقطة إضافية للوصول لمرتبة الروز جولد.',
      'perks': 'المزايا التي تحصل عليها',
      'perk_fast_shipping': 'شحن أولوية لكل طلب',
      'perk_skin_coach': 'جلسات مصغرة مع مدرب بشرة',
      'perk_gifts': 'هدايا مصغرة شهرية',
      'addresses': 'العناوين',
      'add_address': 'أضف عنواناً',
      'no_addresses': 'لا توجد عناوين محفوظة',
      'label': 'اسم العنوان',
      'details': 'تفاصيل',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'new_address': 'عنوان جديد',
      'skin_quiz': 'اختبار البشرة',
      'routine_planner': 'مخطط الروتين',
      'morning': 'الصباح',
      'evening': 'المساء',
      'see_recommendations': 'عرض التوصيات',
      'quiz_result_title': 'تركيز الروتين',
      'quiz_result_body': 'ننصحك بالبدء مع',
      'close': 'إغلاق',
      'order': 'طلب',
      'status': 'الحالة',
      'delivery': 'التوصيل',
      'payment_method': 'طريقة الدفع',
      'items': 'العناصر',
      'subtotal': 'المجموع الفرعي',
      'total': 'الإجمالي',
      'currency': 'ريال',
      'guest': 'ضيف',
      'logout': 'تسجيل الخروج',
      'address': 'العنوان',
      'wellness_hub': 'استوديو العناية',
      'take_quiz': 'ابدأ اختبار البشرة',
      'plan_routine': 'خطط للروتين',
      'track_rewards': 'تابع المكافآت',
    },
  };

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    _AppLocalizationsDelegate(),
  ];

  static const supportedLocales = [Locale('en'), Locale('ar')];

  String t(String key) => _localizedStrings[locale.languageCode]?[key] ?? key;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
