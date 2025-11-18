import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../localization/app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const BottomNavBar({super.key, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onChanged,
      items: [
        BottomNavigationBarItem(icon: const Icon(IconlyLight.home), label: loc.t('home')),
        BottomNavigationBarItem(icon: const Icon(IconlyLight.category), label: loc.t('catalog')),
        BottomNavigationBarItem(icon: const Icon(IconlyLight.heart), label: loc.t('favorites')),
        BottomNavigationBarItem(icon: const Icon(IconlyLight.bag), label: loc.t('cart')),
        BottomNavigationBarItem(icon: const Icon(IconlyLight.profile), label: loc.t('profile')),
      ],
    );
  }
}
