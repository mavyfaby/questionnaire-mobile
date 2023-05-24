class QuestionnaireModel {
  final int id;
  final String question;
  final List<String> choices;
  final int? answer;

  QuestionnaireModel({
    required this.id,
    required this.question,
    required this.choices,
    this.answer
  });

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireModel(
      id: json["id"],
      question: json["question"],
      choices: json["choices"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'choices': choices
    };
  }
}