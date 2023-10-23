class MatchLineupBBModel {
  MatchLineupBBTeamModel hostTeam;
  MatchLineupBBTeamModel guestTeam;
  List<List<String>> hostDataArr2 = [];
  List<List<String>> guestDataArr2 = [];

  MatchLineupBBModel({
    required this.hostTeam,
    required this.guestTeam,
  });

  List<List<String>> obtainDataArr2(List<MatchLineupBBPlayerModel> playerArr) {
    List<List<String>> dataArrArr = [];

    List<String> dataArr1 = ["分钟"];
    List<String> dataArr2 = ["得分"];
    List<String> dataArr3 = ["篮板"];
    List<String> dataArr4 = ["助攻"];
    List<String> dataArr5 = ["盖帽"];
    List<String> dataArr6 = ["抢断"];
    List<String> dataArr7 = ["投篮"];
    List<String> dataArr8 = ["3分"];
    List<String> dataArr9 = ["罚球"];
    List<String> dataArr10 = ["失误"];
    List<String> dataArr11 = ["犯规"];
    List<String> dataArr12 = ["前板"];
    List<String> dataArr13 = ["后板"];
    List<String> dataArr14 = ["+/-"];

    for (MatchLineupBBPlayerModel player in playerArr) {
      dataArr1.add("${player.playTime}'");
      dataArr2.add("${player.rebound}");
      dataArr3.add("${player.point}");
      dataArr4.add("${player.assist}");
      dataArr5.add("${player.block}");
      dataArr6.add("${player.steal}");

      dataArr7.add("${player.fieldGoalMade}-${player.freeThrowAttempted}");
      dataArr8.add("${player.threePointMade}-${player.threePointAttempted}");
      dataArr9.add("${player.freeThrowMade}-${player.freeThrowAttempted}");

      dataArr10.add("${player.turnover}");
      dataArr11.add("${player.foul}");
      dataArr12.add("${player.offensiveRebound}");
      dataArr13.add("${player.defensiveRebound}");
      dataArr14.add("${player.plusMinus}");
    }

    dataArrArr.add(dataArr1);
    dataArrArr.add(dataArr2);
    dataArrArr.add(dataArr3);
    dataArrArr.add(dataArr4);
    dataArrArr.add(dataArr5);
    dataArrArr.add(dataArr6);
    dataArrArr.add(dataArr7);
    dataArrArr.add(dataArr8);
    dataArrArr.add(dataArr9);
    dataArrArr.add(dataArr10);
    dataArrArr.add(dataArr11);
    dataArrArr.add(dataArr12);
    dataArrArr.add(dataArr13);
    dataArrArr.add(dataArr14);

    return dataArrArr;
  }
}

class MatchLineupBBTeamModel {
  String teamName;
  String teamLogo;
  int score;
  List<MatchLineupBBPlayerModel> playerStats;

  MatchLineupBBTeamModel({
    required this.teamName,
    required this.teamLogo,
    required this.score,
    required this.playerStats,
  });

  factory MatchLineupBBTeamModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupBBTeamModel(
      teamName: json['teamName'] ?? '',
      teamLogo: json['teamLogo'] ?? '',
      score: json['score'] ?? 0,
      playerStats: (json['playerStats'] ?? [])
          .map((e) => MatchLineupBBPlayerModel.fromJson(e))
          .toList(),
    );
  }
}

class MatchLineupBBPlayerModel {
  String playTime;
  bool startedFlag;
  int playerId;
  String name;
  String picUrl;
  String shirtNumber;
  int position;
  int point;
  int rebound;
  int defensiveRebound;
  int offensiveRebound;
  int assist;
  int fieldGoalMade;
  int fieldGoalAttempted;
  int threePointMade;
  int threePointAttempted;
  int freeThrowMade;
  int freeThrowAttempted;
  int steal;
  int block;
  int turnover;
  int foul;
  int plusMinus;

  MatchLineupBBPlayerModel({
    required this.playTime,
    required this.startedFlag,
    required this.playerId,
    required this.name,
    required this.picUrl,
    required this.shirtNumber,
    required this.position,
    required this.point,
    required this.rebound,
    required this.defensiveRebound,
    required this.offensiveRebound,
    required this.assist,
    required this.fieldGoalMade,
    required this.fieldGoalAttempted,
    required this.threePointMade,
    required this.threePointAttempted,
    required this.freeThrowMade,
    required this.freeThrowAttempted,
    required this.steal,
    required this.block,
    required this.turnover,
    required this.foul,
    required this.plusMinus,
  });

  factory MatchLineupBBPlayerModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupBBPlayerModel(
      playTime: json['playTime'] ?? '',
      startedFlag: json['startedFlag'] ?? false,
      playerId: json['playerId'] ?? 0,
      name: json['name'] ?? '',
      picUrl: json['picUrl'] ?? '',
      shirtNumber: json['shirtNumber'] ?? '',
      position: json['position'] ?? 0,
      point: json['point'] ?? 0,
      rebound: json['rebound'] ?? 0,
      defensiveRebound: json['defensiveRebound'] ?? 0,
      offensiveRebound: json['offensiveRebound'] ?? 0,
      assist: json['assist'] ?? 0,
      fieldGoalMade: json['fieldGoalMade'] ?? 0,
      fieldGoalAttempted: json['fieldGoalAttempted'] ?? 0,
      threePointMade: json['threePointMade'] ?? 0,
      threePointAttempted: json['threePointAttempted'] ?? 0,
      freeThrowMade: json['freeThrowMade'] ?? 0,
      freeThrowAttempted: json['freeThrowAttempted'] ?? 0,
      steal: json['steal'] ?? 0,
      block: json['block'] ?? 0,
      turnover: json['turnover'] ?? 0,
      foul: json['foul'] ?? 0,
      plusMinus: json['plusMinus'] ?? 0,
    );
  }
}
