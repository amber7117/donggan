import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/wz_date_utils.dart';

class MatchInfoModel {
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
  int awayTeamNormalScore;
  int? guestTeamRank;

  int hostTeamId;
  String hostTeamFullName;
  String hostTeamLogo;
  String hostTeamName;

  int hostTeamScore;
  int hostHalfScore;
  int homeTeamNormalScore;
  int? hostTeamRank;

  String timePlayed;
  int matchTime;

  int status;
  int statusCode;
  int sportType;
  String animUrl;

  int hasAnchor;
  int hasLive;
  int hasVid;

  int lmtMode;

  String matchTimeNew = "";
  bool focus = false;
  bool userIsAppointment = false;

  MatchInfoModel(
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
      required this.awayTeamNormalScore,
      required this.guestTeamRank,
      required this.hostTeamId,
      required this.hostTeamFullName,
      required this.hostTeamLogo,
      required this.hostTeamName,
      required this.hostTeamScore,
      required this.hostHalfScore,
      required this.homeTeamNormalScore,
      required this.hostTeamRank,
      required this.timePlayed,
      required this.matchTime,
      required this.status,
      required this.statusCode,
      required this.sportType,
      required this.animUrl,
      required this.hasAnchor,
      required this.hasLive,
      required this.hasVid,
      required this.lmtMode,
      required this.matchTimeNew});

  factory MatchInfoModel.fromJson(Map<String, dynamic> json) {
    return MatchInfoModel(
      matchId: json['matchId'],
      leagueName: json['leagueName'],
      leagueId: json['leagueId'],
      leagueColor: json['leagueColor'],
      leagueLogo: json['leagueLogo'],
      level: json['level'],
      guestTeamId: json['guestTeamId'],
      guestTeamFullName: json['guestTeamFullName'],
      guestTeamLogo: json['guestTeamLogo'],
      guestTeamName: json['guestTeamName'],
      guestTeamScore: json['guestTeamScore'],
      guestHalfScore: json['guestHalfScore'],
      awayTeamNormalScore: json['awayTeamNormalScore'],
      guestTeamRank: json['guestTeamRank'],
      hostTeamId: json['hostTeamId'],
      hostTeamFullName: json['hostTeamFullName'],
      hostTeamLogo: json['hostTeamLogo'],
      hostTeamName: json['hostTeamName'],
      hostTeamScore: json['hostTeamScore'],
      hostHalfScore: json['hostHalfScore'],
      homeTeamNormalScore: json['homeTeamNormalScore'],
      hostTeamRank: json['hostTeamRank'],
      timePlayed: json['timePlayed'] != null
          ? AppBusinessUtils.obtainMatchTimeDesc(json['timePlayed'])
          : "",
      matchTime: json['matchTime'],
      matchTimeNew: json['matchTime'] != null
          ? WZDateUtils.getDateString(json['matchTime'], "HH:mm")
          : "00:00",
      status: json['status'],
      statusCode: json['statusCode'],
      sportType: json['sportType'],
      animUrl: json['animUrl'] ?? "",
      hasAnchor: json['hasAnchor'],
      hasLive: json['hasLive'],
      hasVid: json['hasVid'],
      lmtMode: json['lmtMode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['matchId'] = matchId;
    data['leagueName'] = leagueName;
    data['leagueId'] = leagueId;
    data['leagueColor'] = leagueColor;
    data['leagueLogo'] = leagueLogo;
    data['level'] = level;

    data['guestTeamId'] = guestTeamId;
    data['guestTeamFullName'] = guestTeamFullName;
    data['guestTeamLogo'] = guestTeamLogo;
    data['guestTeamName'] = guestTeamName;
    data['guestTeamScore'] = guestTeamScore;
    data['guestHalfScore'] = guestHalfScore;
    data['awayTeamNormalScore'] = awayTeamNormalScore;
    data['guestTeamRank'] = guestTeamRank;

    data['hostTeamId'] = hostTeamId;
    data['hostTeamFullName'] = hostTeamFullName;
    data['hostTeamLogo'] = hostTeamLogo;
    data['hostTeamName'] = hostTeamName;
    data['hostTeamScore'] = hostTeamScore;
    data['hostHalfScore'] = hostHalfScore;
    data['homeTeamNormalScore'] = homeTeamNormalScore;
    data['hostTeamRank'] = hostTeamRank;

    data['timePlayed'] = timePlayed;
    data['matchTime'] = matchTime;
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['sportType'] = sportType;
    data['animUrl'] = animUrl;

    data['hasAnchor'] = hasAnchor;
    data['hasLive'] = hasLive;
    data['hasVid'] = hasVid;
    data['lmtMode'] = lmtMode;

    return data;
  }
}
