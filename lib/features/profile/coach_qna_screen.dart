import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class CoachQnaScreen extends StatefulWidget {
  const CoachQnaScreen({super.key});

  @override
  State<CoachQnaScreen> createState() => _CoachQnaScreenState();
}

class _CoachQnaScreenState extends State<CoachQnaScreen> {
  final TextEditingController _promptController = TextEditingController();

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('coach_qna'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.t('coach_qna_hint'),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).hintColor)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promptController,
                    decoration: InputDecoration(
                      hintText: loc.t('ask_question'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    scope.engagementController
                        .addCoachQuestion(_promptController.text);
                    _promptController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  child: Text(loc.t('submit_question')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: scope.engagementController.coachQna,
                builder: (_, list, __) {
                  if (list.isEmpty) {
                    return Center(
                      child: Text(loc.t('no_questions_yet')),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (_, index) {
                      final qna = list[index];
                      final statusLabel =
                          qna.isAnswered ? loc.t('answered') : loc.t('pending_answer');
                      final color = qna.isAnswered
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                          : Theme.of(context).colorScheme.error.withOpacity(0.08);
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  statusLabel,
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  '${qna.createdAt.month}/${qna.createdAt.day}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Theme.of(context).hintColor),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(qna.question,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            Text(
                              qna.answer,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: list.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
