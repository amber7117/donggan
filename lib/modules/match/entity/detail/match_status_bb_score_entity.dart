// ignore_for_file: non_constant_identifier_names

class MatchStatusBBScoreModel {
  MatchStatusBBScorePeriodModel? Period1;
  MatchStatusBBScorePeriodModel? Period2;
  MatchStatusBBScorePeriodModel? Period3;
  MatchStatusBBScorePeriodModel? Period4;
  MatchStatusBBScorePeriodModel? Overtime;

  MatchStatusBBScorePeriodModel? Current;

  List<MatchStatusBBScorePeriodLocalModel> dataModelArr = [];

  MatchStatusBBScoreModel(
      {this.Period1,
      this.Period2,
      this.Period3,
      this.Period4,
      this.Overtime,
      this.Current}) {
    _processData();
  }

  _processData() {
    MatchStatusBBScorePeriodLocalModel model1 =
        MatchStatusBBScorePeriodLocalModel(title: "-");
    if (Period1 != null) {
      model1.team1 = Period1!.team1;
      model1.team2 = Period1!.team2;
    }
    dataModelArr.add(model1);

    model1 = MatchStatusBBScorePeriodLocalModel(title: "二");
    if (Period2 != null) {
      model1.team1 = Period2!.team1;
      model1.team2 = Period2!.team2;
    }
    dataModelArr.add(model1);

    model1 = MatchStatusBBScorePeriodLocalModel(title: "三");
    if (Period3 != null) {
      model1.team1 = Period3!.team1;
      model1.team2 = Period3!.team2;
    }
    dataModelArr.add(model1);

    model1 = MatchStatusBBScorePeriodLocalModel(title: "四");
    if (Period4 != null) {
      model1.team1 = Period4!.team1;
      model1.team2 = Period4!.team2;
    }
    dataModelArr.add(model1);

    if (Overtime != null) {
      model1 = MatchStatusBBScorePeriodLocalModel(title: "OT");
      model1.team1 = Overtime!.team1;
      model1.team2 = Overtime!.team2;
      dataModelArr.add(model1);
    }

    model1 = MatchStatusBBScorePeriodLocalModel(title: "总分");
    if (Current != null) {
      model1.team1 = Current!.team1;
      model1.team2 = Current!.team2;
    }
    dataModelArr.add(model1);
  }
}

class MatchStatusBBScorePeriodModel {
  int type;
  int typeCode;

  int team1;
  int team2;

  MatchStatusBBScorePeriodModel(
      {required this.type,
      required this.typeCode,
      required this.team1,
      required this.team2});

  factory MatchStatusBBScorePeriodModel.fromJson(Map<String, dynamic> json) {
    return MatchStatusBBScorePeriodModel(
      type: json['type'] ?? 0,
      typeCode: json['typeCode'] ?? 0,
      team1: json['team1'] ?? 0,
      team2: json['team2'] ?? 0,
    );
  }
}

class MatchStatusBBScorePeriodLocalModel {
  int team1;
  int team2;

  String title;

  MatchStatusBBScorePeriodLocalModel({
    this.team1 = -1,
    this.team2 = -1,
    this.title = "",
  });
}
