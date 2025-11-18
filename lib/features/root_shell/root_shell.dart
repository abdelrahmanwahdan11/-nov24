import 'package:flutter/material.dart';
import '../../core/controllers/product_controller.dart';
import '../../core/controllers/cart_controller.dart';
import '../../core/controllers/favorites_controller.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../main.dart';
import '../home/home_screen.dart';
import '../catalog/catalog_screen.dart';
import '../favorites/favorites_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int index = 0;
  late ProductController productController;
  late CartController cartController;
  late FavoritesController favoritesController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = AppScope.of(context);
    productController = scope.productController;
    cartController = scope.cartController;
    favoritesController = scope.favoritesController;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(controller: productController, favoritesController: favoritesController, cartController: cartController),
      CatalogScreen(controller: productController, favoritesController: favoritesController, cartController: cartController),
      FavoritesScreen(controller: favoritesController, cartController: cartController),
      CartScreen(controller: cartController),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: BottomNavBar(index: index, onChanged: (i) => setState(() => index = i)),
    );
  }
}
