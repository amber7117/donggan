import 'package:wzty/utils/wz_date_utils.dart';

class MatchCalendarEntity {
  int matchId;
  String sportId;
  String tournamentName;
  int matchTime;
  String hostTeamLogo;
  String hostTeamName;
  String guestTeamLogo;
  String guestTeamName;
  int status;
  int statusCode;
  bool userIsAppointment;
  late String matchTimeNew;

  MatchCalendarEntity({
    required this.matchId,
    required this.sportId,
    required this.tournamentName,
    required this.matchTime,
    required this.hostTeamLogo,
    required this.hostTeamName,
    required this.guestTeamLogo,
    required this.guestTeamName,
    required this.status,
    required this.statusCode,
    required this.userIsAppointment,
  }) {
    if (matchTime > 0) {
      matchTimeNew = WZDateUtils.getDateString(matchTime, "HH:mm");
    } else {
      matchTimeNew = "HH:mm";
    }
  }

  factory MatchCalendarEntity.fromJson(Map<String, dynamic> json) {
    return MatchCalendarEntity(
      matchId: json['matchId'] ?? 0,
      sportId: json['sportId'] ?? "",
      tournamentName: json['tournamentName'] ?? "",
      matchTime: json['matchTime'] ?? 0,
      hostTeamLogo: json['hostTeamLogo'] ?? "",
      hostTeamName: json['hostTeamName'] ?? "",
      guestTeamLogo: json['guestTeamLogo'] ?? "",
      guestTeamName: json['guestTeamName'] ?? "",
      status: json['status'] ?? 0,
      statusCode: json['statusCode'] ?? 0,
      userIsAppointment: json['userIsAppointment'] ?? false,
    );
  }
}
