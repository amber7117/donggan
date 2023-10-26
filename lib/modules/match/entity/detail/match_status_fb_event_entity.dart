class MatchStatusFBEventModel {
  // MARK: - Property

  int eventId;

  int team;
  int stage;
  int typeId;
  int goalType;
  int occurTime;
  int overTime;

  String iconType;

  String playerName;
  String playerName2;
  String content;
  String content2;
  String scores;

  int statusCode;
  String statusName;

  // MARK: - Constructor

  MatchStatusFBEventModel(
      {required this.eventId,
      required this.team,
      required this.stage,
      required this.typeId,
      required this.goalType,
      required this.occurTime,
      required this.overTime,
      required this.iconType,
      required this.playerName,
      required this.playerName2,
      required this.content,
      required this.content2,
      required this.scores,
      required this.statusCode,
      required this.statusName});

  // MARK: - JSON Conversion

  factory MatchStatusFBEventModel.fromJson(Map<String, dynamic> json) {
    return MatchStatusFBEventModel(
        eventId: json['eventId'] ?? 0,
        team: json['team'] ?? 0,
        stage: json['stage'] ?? 0,
        typeId: json['typeId'] ?? 0,
        goalType: json['goalType'] ?? 0,
        occurTime: json['occurTime'] ?? 0,
        overTime: json['overTime'] ?? 0,
        iconType: json['iconType'] ?? "",
        playerName: json['playerName'] ?? "",
        playerName2: json['playerName2'] ?? "",
        content: json['content'] ?? "",
        content2: json['content2'] ?? "",
        scores: json['scores'] ?? "",
        statusCode: json['statusCode'] ?? 0,
        statusName: json['statusName'] ?? "");
  }
}

