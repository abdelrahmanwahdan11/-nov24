class CoachQna {
  final String id;
  final String question;
  final String answer;
  final bool isAnswered;
  final DateTime createdAt;

  const CoachQna({
    required this.id,
    required this.question,
    required this.answer,
    required this.isAnswered,
    required this.createdAt,
  });

  CoachQna copyWith({String? answer, bool? isAnswered}) {
    return CoachQna(
      id: id,
      question: question,
      answer: answer ?? this.answer,
      isAnswered: isAnswered ?? this.isAnswered,
      createdAt: createdAt,
    );
  }
}
