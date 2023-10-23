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
      {required this.eventId,
      required this.team,
      required this.time,
      required this.period,
      required this.hostScore,
      required this.guestScore,
      required this.typeId,
      required this.cnText,
      required this.section,
      required this.teamName});

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
