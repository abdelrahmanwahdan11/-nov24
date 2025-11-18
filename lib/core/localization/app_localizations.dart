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
