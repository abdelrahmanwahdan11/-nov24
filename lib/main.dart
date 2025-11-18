import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_controller.dart';
import 'core/controllers/auth_controller.dart';
import 'core/controllers/product_controller.dart';
import 'core/controllers/cart_controller.dart';
import 'core/controllers/favorites_controller.dart';
import 'core/controllers/settings_controller.dart';
import 'core/controllers/search_controller.dart';
import 'core/routing/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SkinCareApp());
}

class SkinCareApp extends StatefulWidget {
  const SkinCareApp({super.key});

  @override
  State<SkinCareApp> createState() => _SkinCareAppState();
}

class _SkinCareAppState extends State<SkinCareApp> {
  final ThemeController _themeController = ThemeController();
  final LocaleController _localeController = LocaleController();
  final AuthController _authController = AuthController();
  final ProductController _productController = ProductController();
  late final CartController _cartController;
  late final FavoritesController _favoritesController;
  late final SettingsController _settingsController;
  late final SearchController _searchController;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _cartController = CartController();
    _favoritesController = FavoritesController();
    _settingsController = SettingsController(_themeController, _localeController);
    _searchController = SearchController(_productController);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.wait([
      _themeController.load(),
      _localeController.load(),
      _authController.load(),
      _productController.loadInitialHomeData(),
      _productController.refreshCatalog(),
    ]);
    setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _productController.dispose();
    _cartController.dispose();
    _favoritesController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator())));
    }
    return ValueListenableBuilder(
      valueListenable: _themeController.primaryColor,
      builder: (_, primary, __) {
        return ValueListenableBuilder(
          valueListenable: _themeController.themeMode,
          builder: (_, mode, __) {
            return ValueListenableBuilder(
              valueListenable: _localeController.locale,
              builder: (_, locale, __) {
                return AppScope(
                  themeController: _themeController,
                  localeController: _localeController,
                  authController: _authController,
                  productController: _productController,
                  cartController: _cartController,
                  favoritesController: _favoritesController,
                  settingsController: _settingsController,
                  searchController: _searchController,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    locale: locale,
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    onGenerateRoute: AppRouter.onGenerate,
                    theme: AppTheme.light(primary),
                    darkTheme: AppTheme.dark(primary),
                    themeMode: mode,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class AppScope extends InheritedWidget {
  final ThemeController themeController;
  final LocaleController localeController;
  final AuthController authController;
  final ProductController productController;
  final CartController cartController;
  final FavoritesController favoritesController;
  final SettingsController settingsController;
  final SearchController searchController;

  const AppScope({super.key, required super.child, required this.themeController, required this.localeController, required this.authController, required this.productController, required this.cartController, required this.favoritesController, required this.settingsController, required this.searchController});

  static AppScope of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppScope>()!;

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) => true;
}
