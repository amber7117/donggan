class ProblemEntity {
  String question;
  List<AnswerList> answerList;
  bool showAll = false;

  ProblemEntity({
    required this.question,
    required this.answerList,
  });

  factory ProblemEntity.fromJson(Map<String, dynamic> json) => ProblemEntity(
        question: json["question"],
        answerList: List<AnswerList>.from(
            json["answerList"].map((x) => AnswerList.fromJson(x))),
      );
}

class AnswerList {
  String ask;
  String answer;
  String? highlight;

  AnswerList({
    required this.ask,
    required this.answer,
    this.highlight,
  });

  factory AnswerList.fromJson(Map<String, dynamic> json) => AnswerList(
        ask: json["ask"],
        answer: json["answer"],
        highlight: json["highlight"],
      );
}
