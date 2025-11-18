import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;
  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final code = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(article.localizedTitle(code))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(article.imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Chip(label: Text(article.tag)),
              const SizedBox(width: 8),
              Text('${article.minutesRead} ${loc.t('minutes')}'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            article.localizedTitle(code),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            article.localizedSummary(code),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            '• ${loc.t('journal_intro')}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '• ${loc.t('diary_intro')}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
