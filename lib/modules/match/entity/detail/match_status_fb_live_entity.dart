class MatchStatusFBLiveModel {
  // MARK: - Property

  int eventId;

  int team;
  String time;

  int period;
  int hostScore;
  int guestScore;
  int typeId;

  String cnText;
  String section;
  String teamName;

  // MARK: - Constructor

  MatchStatusFBLiveModel(
      {this.eventId = 0,
      this.team = 0,
      this.time = "",
      this.period = 0,
      this.hostScore = 0,
      this.guestScore = 0,
      this.typeId = 0,
      this.cnText = "",
      this.section = "",
      this.teamName = ""});

  // MARK: - JSON Conversion

  factory MatchStatusFBLiveModel.fromJson(Map<String, dynamic> json) {
    return MatchStatusFBLiveModel(
        eventId: json['eventId'] ?? 0,
        team: json['team'] ?? 0,
        time: json['time'] ?? "",
        period: json['period'] ?? 0,
        hostScore: json['hostScore'] ?? 0,
        guestScore: json['guestScore'] ?? 0,
        typeId: json['typeId'] ?? 0,
        cnText: json['cnText'] ?? "",
        section: json['section'] ?? "",
        teamName: json['teamName'] ?? "");
  }
}
