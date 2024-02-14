import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/wz_date_utils.dart';

class MatchListModel {
  int matchId;

  String leagueName;
  int leagueId;
  String leagueColor;
  String leagueLogo;
  int level;

  int guestTeamId;
  String guestTeamFullName;
  String guestTeamLogo;
  String guestTeamName;

  int guestTeamScore;
  int guestHalfScore;
  int guestTeamRank;

  int hostTeamId;
  String hostTeamFullName;
  String hostTeamLogo;
  String hostTeamName;

  int hostTeamScore;
  int hostHalfScore;
  int hostTeamRank;

  String timePlayed;
  String statusLable;
  int matchTime;

  int status;
  int statusCode;
  int sportType;
  String animUrl;

  int hasAnchor;
  int hasLive;
  int hasVid;

  int lmtMode;

  late String matchTimeNew;

  bool focus = false;
  bool userIsAppointment = false;

  MatchListModel(
      {required this.matchId,
      required this.leagueName,
      required this.leagueId,
      required this.leagueColor,
      required this.leagueLogo,
      required this.level,
      required this.guestTeamId,
      required this.guestTeamFullName,
      required this.guestTeamLogo,
      required this.guestTeamName,
      required this.guestTeamScore,
      required this.guestHalfScore,
      required this.guestTeamRank,
      required this.hostTeamId,
      required this.hostTeamFullName,
      required this.hostTeamLogo,
      required this.hostTeamName,
      required this.hostTeamScore,
      required this.hostHalfScore,
      required this.hostTeamRank,
      required this.timePlayed,
      required this.statusLable,
      required this.matchTime,
      required this.status,
      required this.statusCode,
      required this.sportType,
      required this.animUrl,
      required this.hasAnchor,
      required this.hasLive,
      required this.hasVid,
      required this.lmtMode}) {
    if (matchTime > 0) {
      matchTimeNew = WZDateUtils.getDateString(matchTime, "HH:mm");
    } else {
      matchTimeNew = "HH:mm";
    }
  }

  factory MatchListModel.fromJson(Map<String, dynamic> json) {
    return MatchListModel(
      matchId: json['matchId'] ?? 0,
      leagueName: json['leagueName'] ?? "",
      leagueId: json['leagueId'] ?? 0,
      leagueColor: json['leagueColor'] ?? "",
      leagueLogo: json['leagueLogo'] ?? "",
      level: json['level'] ?? 0,
      guestTeamId: json['guestTeamId'] ?? 0,
      guestTeamFullName: json['guestTeamFullName'] ?? "",
      guestTeamLogo: json['guestTeamLogo'] ?? "",
      guestTeamName: json['guestTeamName'] ?? "",
      guestTeamScore: json['guestTeamScore'] ?? 0,
      guestHalfScore: json['guestHalfScore'] ?? 0,
      guestTeamRank: json['guestTeamRank'] ?? 0,
      hostTeamId: json['hostTeamId'] ?? 0,
      hostTeamFullName: json['hostTeamFullName'] ?? "",
      hostTeamLogo: json['hostTeamLogo'] ?? "",
      hostTeamName: json['hostTeamName'] ?? "",
      hostTeamScore: json['hostTeamScore'] ?? 0,
      hostHalfScore: json['hostHalfScore'] ?? 0,
      hostTeamRank: json['hostTeamRank'] ?? 0,
      timePlayed: json['timePlayed'] != null
          ? AppBusinessUtils.obtainMatchTimeDesc(json['timePlayed'])
          : "",
      statusLable: json['statusLable'] ?? "",
      matchTime: json['matchTime'] ?? 0,
      status: json['status'] ?? 0,
      statusCode: json['statusCode'] ?? 0,
      sportType: json['sportType'] ?? 0,
      animUrl: json['animUrl'] ?? "",
      hasAnchor: json['hasAnchor'] ?? 0,
      hasLive: json['hasLive'] ?? 0,
      hasVid: json['hasVid'] ?? 0,
      lmtMode: json['lmtMode'] ?? 0,
    );
  }
}
