import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/models/skin_quiz_question.dart';
import '../../main.dart';

class SkinQuizScreen extends StatefulWidget {
  const SkinQuizScreen({super.key});

  @override
  State<SkinQuizScreen> createState() => _SkinQuizScreenState();
}

class _SkinQuizScreenState extends State<SkinQuizScreen> {
  final Map<int, String> _answers = {};

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final questions = scope.engagementController.quizQuestions;
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('skin_quiz'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index == questions.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ElevatedButton(
                onPressed: _answers.length == questions.length
                    ? () {
                        scope.engagementController
                            .selectQuizAnswers(_answers.values.toList());
                        final summary =
                            scope.engagementController.deriveQuizSummary();
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(loc.t('quiz_result_title')),
                            content: Text('${loc.t('quiz_result_body')} $summary'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(loc.t('close')),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                child: Text(loc.t('see_recommendations')),
              ),
            );
          }
          final SkinQuizQuestion question = questions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: question.options
                        .map(
                          (option) => ChoiceChip(
                            label: Text(option),
                            selected: _answers[index] == option,
                            onSelected: (_) => setState(() {
                              _answers[index] = option;
                            }),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
