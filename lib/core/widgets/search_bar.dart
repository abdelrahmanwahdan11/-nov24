import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

class AppSearchBar extends StatelessWidget {
  final VoidCallback onTap;
  const AppSearchBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 8),
            Text(loc.t('search_products')),
          ],
        ),
      ),
    );
  }
}
