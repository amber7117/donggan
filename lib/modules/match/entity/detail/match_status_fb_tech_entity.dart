class MatchStatusFBTechModel {
  // MARK: - Property

  MatchStatusFBTechDataModel? cornerKicks;
  MatchStatusFBTechDataModel? yellowCards;
  MatchStatusFBTechDataModel? redCards;

  MatchStatusFBTechDataModel? attack;
  MatchStatusFBTechDataModel? dangerAttack;

  MatchStatusFBTechDataModel? fouls;
  MatchStatusFBTechDataModel? shootOnGoal;
  MatchStatusFBTechDataModel? goalKicks;
  MatchStatusFBTechDataModel? shootOffGoal;
  MatchStatusFBTechDataModel? throwIns;
  MatchStatusFBTechDataModel? pass;
  MatchStatusFBTechDataModel? freeKicks;

  MatchStatusFBTechDataModel? crosses;
  MatchStatusFBTechDataModel? crossesSuccess;
  MatchStatusFBTechDataModel? possession;
  MatchStatusFBTechDataModel? accuratePasses;

  MatchStatusFBTechDataModel? bigChances;
  MatchStatusFBTechDataModel? longBalls;
  MatchStatusFBTechDataModel? clearances;
  MatchStatusFBTechDataModel? longBallsSuccess;
  MatchStatusFBTechDataModel? aerialsWon;

  List<MatchStatusFBTechLocalModel> dataModelArr = [];

  // MARK: - Constructor

  MatchStatusFBTechModel(
      {this.cornerKicks,
      this.yellowCards,
      this.redCards,
      this.attack,
      this.dangerAttack,
      this.fouls,
      this.shootOnGoal,
      this.goalKicks,
      this.shootOffGoal,
      this.throwIns,
      this.pass,
      this.freeKicks,
      this.crosses,
      this.crossesSuccess,
      this.possession,
      this.accuratePasses,
      this.bigChances,
      this.longBalls,
      this.clearances,
      this.longBallsSuccess,
      this.aerialsWon}) {
    _processData();
  }

  _processData() {
    if (bigChances != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "绝佳机会", team1: bigChances!.team1, team2: bigChances!.team2);
      dataModelArr.add(model);
    }

    if (freeKicks != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "任意球", team1: freeKicks!.team1, team2: freeKicks!.team2);
      dataModelArr.add(model);
    }

    if (throwIns != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "边线球", team1: throwIns!.team1, team2: throwIns!.team2);
      dataModelArr.add(model);
    }

    if (fouls != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "犯规", team1: fouls!.team1, team2: fouls!.team2);
      dataModelArr.add(model);
    }

    if (pass != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "传球", team1: pass!.team1, team2: pass!.team2);
      dataModelArr.add(model);
    }

    if (accuratePasses != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "传球成功",
          team1: accuratePasses!.team1,
          team2: accuratePasses!.team2);
      dataModelArr.add(model);
    }

    if (crosses != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "传中", team1: crosses!.team1, team2: crosses!.team2);
      dataModelArr.add(model);
    }

    if (crossesSuccess != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "传中成功",
          team1: crossesSuccess!.team1,
          team2: crossesSuccess!.team2);
      dataModelArr.add(model);
    }

    if (longBalls != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "长传", team1: longBalls!.team1, team2: longBalls!.team2);
      dataModelArr.add(model);
    }

    if (longBallsSuccess != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "长传成功",
          team1: longBallsSuccess!.team1,
          team2: longBallsSuccess!.team2);
      dataModelArr.add(model);
    }

    if (aerialsWon != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "争顶成功", team1: aerialsWon!.team1, team2: aerialsWon!.team2);
      dataModelArr.add(model);
    }

    if (clearances != null) {
      var model = MatchStatusFBTechLocalModel(
          title: "解围", team1: clearances!.team1, team2: clearances!.team2);
      dataModelArr.add(model);
    }
  }

  // MARK: - JSON Serialization

  factory MatchStatusFBTechModel.fromJson(Map<String, dynamic> json) {
    return MatchStatusFBTechModel(
        cornerKicks: json["cornerKicks"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["cornerKicks"]),
        yellowCards: json["yellowCards"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["yellowCards"]),
        redCards: json["redCards"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["redCards"]),
        attack: json["attack"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["attack"]),
        dangerAttack: json["dangerAttack"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["dangerAttack"]),
        fouls: json["fouls"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["fouls"]),
        shootOnGoal: json["shootOnGoal"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["shootOnGoal"]),
        goalKicks: json["goalKicks"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["goalKicks"]),
        shootOffGoal: json["shootOffGoal"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["shootOffGoal"]),
        throwIns: json["throwIns"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["throwIns"]),
        pass: json["pass"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["pass"]),
        freeKicks: json["freeKicks"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["freeKicks"]),
        crosses: json["crosses"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["crosses"]),
        crossesSuccess: json["crossesSuccess"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["crossesSuccess"]),
        possession: json["possession"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["possession"]),
        accuratePasses: json["accuratePasses"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["accuratePasses"]),
        bigChances: json["bigChances"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["bigChances"]),
        longBalls: json["longBalls"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["longBalls"]),
        clearances: json["clearances"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["clearances"]),
        longBallsSuccess: json["longBallsSuccess"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["longBallsSuccess"]),
        aerialsWon: json["aerialsWon"] == null
            ? null
            : MatchStatusFBTechDataModel.fromJson(json["aerialsWon"]));
  }
}

class MatchStatusFBTechDataModel {
  // MARK: - Property

  int matchId;

  int typeId;
  int type;
  int team1;
  int team2;

  int periodType;
  int side;
  int typeCode;

  // MARK: - Constructor

  MatchStatusFBTechDataModel(
      {required this.matchId,
      required this.typeId,
      required this.type,
      required this.team1,
      required this.team2,
      required this.periodType,
      required this.side,
      required this.typeCode});

  // MARK: - JSON Serialization

  factory MatchStatusFBTechDataModel.fromJson(Map<String, dynamic> json) {
    return MatchStatusFBTechDataModel(
        matchId: json["matchId"] ?? 0,
        typeId: json["typeId"] ?? 0,
        type: json["type"] ?? 0,
        team1: json["team1"] ?? 0,
        team2: json["team2"] ?? 0,
        periodType: json["periodType"] ?? 0,
        side: json["side"] ?? 0,
        typeCode: json["typeCode"] ?? 0,
    );
  }
}

class MatchStatusFBTechLocalModel {
  // MARK: - Property

  final String title;

  final int team1;
  final int team2;

  final bool isPercent;

  // MARK: - Constructor

  const MatchStatusFBTechLocalModel(
      {required this.title,
      required this.team1,
      required this.team2,
      this.isPercent = false});
}
