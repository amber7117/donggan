import 'package:wzty/utils/wz_date_utils.dart';

class MatchAnalysisRankTeamModel {
  int teamId;
  String leagueName;
  String logo;
  int teamRank;
  int matchCount;
  int win;
  int lost;
  int draw;
  int goal;
  int lostGoal;
  int point;
  double points;
  double lostPoints;
  int continuousStatus;

  MatchAnalysisRankTeamModel({
    required this.teamId,
    required this.leagueName,
    required this.logo,
    required this.teamRank,
    required this.matchCount,
    required this.win,
    required this.lost,
    required this.draw,
    required this.goal,
    required this.lostGoal,
    required this.point,
    required this.points,
    required this.lostPoints,
    required this.continuousStatus,
  });

  factory MatchAnalysisRankTeamModel.fromJson(Map<String, dynamic> json) {
    return MatchAnalysisRankTeamModel(
      teamId: json['teamId'] ?? 0,
      leagueName: json['leagueName'] ?? '',
      logo: json['logo'] ?? '',
      teamRank: json['teamRank'] ?? 0,
      matchCount: json['matchCount'] ?? 0,
      win: json['win'] ?? 0,
      lost: json['lost'] ?? 0,
      draw: json['draw'] ?? 0,
      goal: json['goal'] ?? 0,
      lostGoal: json['lostGoal'] ?? 0,
      point: json['point'] ?? 0,
      points: json['points'] ?? 0.0,
      lostPoints: json['lostPoints'] ?? 0.0,
      continuousStatus: json['continuousStatus'] ?? 0,
    );
  }
}


class MatchAnalysisHistoryModel {
  int hostWinNum;
  int hostDrawNum;
  int hostLoseNum;
  int hostWinRate;
  int totalNum;
  int hostScore;
  int guestScore;
  String pointsSumPerGame;
  String pointsGetPerGame;
  String pointsLostPerGame;
  String pointsDiffPerGame;
  String winRate;
  int winNum;
  int drawNum;
  int loseNum;
  List<MatchAnalysisMatchModel> matches;

  MatchAnalysisHistoryModel({
    required this.hostWinNum ,
    required this.hostDrawNum,
    required this.hostLoseNum,
    required this.hostWinRate,
    required this.totalNum,
    required this.hostScore,
    required this.guestScore,
    required this.pointsSumPerGame,
    required this.pointsGetPerGame,
    required this.pointsLostPerGame,
    required this.pointsDiffPerGame,
    required this.winRate,
    required this.winNum,
    required this.drawNum,
    required this.loseNum,
    required this.matches,
  });

  factory MatchAnalysisHistoryModel.fromJson(Map<String, dynamic> json) {
    return MatchAnalysisHistoryModel(
      hostWinNum: json['hostWinNum'] ?? 0,
      hostDrawNum: json['hostDrawNum'] ?? 0,
      hostLoseNum: json['hostLoseNum'] ?? 0,
      hostWinRate: json['hostWinRate'] ?? 0,
      totalNum: json['totalNum'] ?? 0,
      hostScore: json['hostScore'] ?? 0,
      guestScore: json['guestScore'] ?? 0,
      pointsSumPerGame: json['pointsSumPerGame'] ?? '',
      pointsGetPerGame: json['pointsGetPerGame'] ?? '',
      pointsLostPerGame: json['pointsLostPerGame'] ?? '',
      pointsDiffPerGame: json['pointsDiffPerGame'] ?? '',
      winRate: json['winRate'] ?? '',
      winNum: json['winNum'] ?? 0,
      drawNum: json['drawNum'] ?? 0,
      loseNum: json['loseNum'] ?? 0,
      matches: List<MatchAnalysisMatchModel>.from(
          (json['matches'] ?? [])
          .map((x) => MatchAnalysisMatchModel.fromJson(x))),
    ); 
  }
}


class MatchAnalysisMatchModel {
  int leagueId;
  String leagueName;
  int matchId;
  int matchTime;
  int hostTeamId;
  String hostTeamName;
  String hostTeamLogo;
  int hostTeamScore;
  int hostTeamNormalScore;
  int hostTeamHalfScore;
  int guestTeamId;
  String guestTeamName;
  String guestTeamLogo;
  int guestTeamScore;
  int guestTeamNormalScore;
  int guestTeamHalfScore;
  int timeInterval;
  
  late String matchTimeNew;

  MatchAnalysisMatchModel({
    required this.leagueId,
    required this.leagueName,
    required this.matchId,
    required this.matchTime,
    required this.hostTeamId,
    required this.hostTeamName,
    required this.hostTeamLogo,
    required this.hostTeamScore,
    required this.hostTeamNormalScore,
    required this.hostTeamHalfScore,
    required this.guestTeamId,
    required this.guestTeamName,
    required this.guestTeamLogo,
    required this.guestTeamScore,
    required this.guestTeamNormalScore,
    required this.guestTeamHalfScore,
    required this.timeInterval,
  }) {
    if (matchTime > 0) {
      matchTimeNew = WZDateUtils.getDateString(matchTime, "yy/MM/dd");
    } else {
      matchTimeNew = "";
    }
  }

  factory MatchAnalysisMatchModel.empty() => MatchAnalysisMatchModel(
    leagueId : 0,
    leagueName : '',
    matchId : 0,
    matchTime : 0,
    hostTeamId : 0,
    hostTeamName : '',
    hostTeamLogo : '',
    hostTeamScore : 0,
    hostTeamNormalScore : 0,
    hostTeamHalfScore : 0,
    guestTeamId : 0,
    guestTeamName : '',
    guestTeamLogo : '',
    guestTeamScore : 0,
    guestTeamNormalScore : 0,
    guestTeamHalfScore : 0,
    timeInterval : 0,
  );

  factory MatchAnalysisMatchModel.fromJson(Map<String, dynamic> json) {
    return MatchAnalysisMatchModel(
      leagueId: json['leagueId'] ?? 0,
      leagueName: json['leagueName'] ?? '',
      matchId: json['matchId'] ?? 0,
      matchTime: json['matchTime'] ?? 0,
      hostTeamId: json['hostTeamId'] ?? 0,
      hostTeamName: json['hostTeamName'] ?? '',
      hostTeamLogo: json['hostTeamLogo'] ?? '',
      hostTeamScore: json['hostTeamScore'] ?? 0,
      hostTeamNormalScore: json['hostTeamNormalScore'] ?? 0,
      hostTeamHalfScore: json['hostTeamHalfScore'] ?? 0,
      guestTeamId: json['guestTeamId'] ?? 0,
      guestTeamName: json['guestTeamName'] ?? '',
      guestTeamLogo: json['guestTeamLogo'] ?? '',
      guestTeamScore: json['guestTeamScore'] ?? 0,
      guestTeamNormalScore: json['guestTeamNormalScore'] ?? 0,
      guestTeamHalfScore: json['guestTeamHalfScore'] ?? 0,
      timeInterval: json['timeInterval'] ?? 0,
    );
  }

}