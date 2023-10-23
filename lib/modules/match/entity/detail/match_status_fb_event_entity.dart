class MatchStatusFBEventModel {
  // MARK: - Property

  int eventId;

  int team;
  int stage;
  int typeId;
  int goalType;
  int occurTime;
  int overTime;

  int iconType;

  String playerName;
  String playerName2;
  String content;
  String content2;
  String scores;

  int statusCode;
  String statusName;

  // MARK: - Constructor

  MatchStatusFBEventModel(
      {this.eventId = 0,
      this.team = 0,
      this.stage = 0,
      this.typeId = 0,
      this.goalType = 0,
      this.occurTime = 0,
      this.overTime = 0,
      this.iconType = 0,
      this.playerName = "",
      this.playerName2 = "",
      this.content = "",
      this.content2 = "",
      this.scores = "",
      this.statusCode = 0,
      this.statusName = ""});

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
        iconType: json['iconType'] ?? 0,
        playerName: json['playerName'] ?? "",
        playerName2: json['playerName2'] ?? "",
        content: json['content'] ?? "",
        content2: json['content2'] ?? "",
        scores: json['scores'] ?? "",
        statusCode: json['statusCode'] ?? 0,
        statusName: json['statusName'] ?? "");
  }
}
