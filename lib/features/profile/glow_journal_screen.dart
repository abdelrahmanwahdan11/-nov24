import 'package:flutter/material.dart';
import '../../core/data/mock_articles.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/routing/app_router.dart';

class GlowJournalScreen extends StatelessWidget {
  const GlowJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final code = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('glow_journal'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockArticles.length,
        itemBuilder: (_, index) {
          final article = mockArticles[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, AppRouter.articleDetails, arguments: article),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(article.imageUrl, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(label: Text(article.tag)),
                            const SizedBox(width: 8),
                            Text('${article.minutesRead} ${loc.t('minutes_read')}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article.localizedTitle(code),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(article.localizedSummary(code)),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, AppRouter.articleDetails, arguments: article),
                          child: Text(loc.t('read_now')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
