import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/section_header.dart';
import '../../core/models/ingredient.dart';
import '../../main.dart';

class IngredientLibraryScreen extends StatefulWidget {
  const IngredientLibraryScreen({super.key});

  @override
  State<IngredientLibraryScreen> createState() => _IngredientLibraryScreenState();
}

class _IngredientLibraryScreenState extends State<IngredientLibraryScreen> {
  String _query = '';
  String _selectedConcern = 'all';

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final chips = {
      'all': loc.t('all'),
      'brightening': loc.t('concern_brightening'),
      'soothing': loc.t('concern_soothing'),
      'hydration': loc.t('concern_hydration'),
      'acne': loc.t('concern_acne'),
      'texture': loc.t('concern_texture'),
    };

    return Scaffold(
      appBar: AppBar(title: Text(loc.t('ingredient_library'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: loc.t('search_ingredients')),
            const SizedBox(height: 8),
            AppTextField(
              hint: loc.t('search_ingredients'),
              onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
              prefix: const Icon(Icons.search),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: chips.entries
                  .map((entry) => ChoiceChip(
                        label: Text(entry.value),
                        selected: _selectedConcern == entry.key,
                        onSelected: (_) => setState(() => _selectedConcern = entry.key),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ValueListenableBuilder<List<Ingredient>>(
                valueListenable: scope.engagementController.ingredients,
                builder: (_, ingredients, __) {
                  final filtered = ingredients.where((ingredient) {
                    final matchesQuery = _query.isEmpty ||
                        ingredient.name(lang).toLowerCase().contains(_query) ||
                        ingredient.summary(lang).toLowerCase().contains(_query);
                    final matchesConcern = _selectedConcern == 'all' ||
                        ingredient.concerns.contains(_selectedConcern);
                    return matchesQuery && matchesConcern;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(child: Text(loc.t('no_ingredients')));
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, index) {
                      final ingredient = filtered[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(ingredient.imageUrl)),
                          title: Text(ingredient.name(lang)),
                          subtitle: Text(ingredient.summary(lang)),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _showDetails(context, ingredient, lang),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, Ingredient ingredient, String lang) {
    final loc = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(ingredient.imageUrl), radius: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ingredient.name(lang),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(ingredient.summary(lang)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Text(loc.t('benefits'), style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                ...ingredient
                    .benefits(lang)
                    .map<Widget>((b) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle, size: 18),
                              const SizedBox(width: 6),
                              Expanded(child: Text(b)),
                            ],
                          ),
                        )),
                const SizedBox(height: 12),
                Text(loc.t('caution'), style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(ingredient.caution(lang)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: ingredient.concerns
                      .map<Widget>((c) => Chip(label: Text(chipLabel(c, loc))))
                      .toList(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String chipLabel(String key, AppLocalizations loc) {
    switch (key) {
      case 'brightening':
        return loc.t('concern_brightening');
      case 'soothing':
        return loc.t('concern_soothing');
      case 'hydration':
        return loc.t('concern_hydration');
      case 'acne':
        return loc.t('concern_acne');
      case 'texture':
        return loc.t('concern_texture');
      case 'oil_control':
        return loc.t('concern_oil');
      default:
        return key;
    }
  }
}
