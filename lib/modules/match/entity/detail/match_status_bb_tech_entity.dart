import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';

class MatchStatusBBTechModel {
  int hostPoint;
  int guestPoint;
  int hostThrow;
  int guestThrow;
  int hostThrowPoint;
  int guestThrowPoint;
  int hostThrPnt;
  int guestThrPnt;
  int hostThrPntMade;
  int guestThrPntMade;
  int hostPnlty;
  int guestPnlty;
  int hostPnltyPoint;
  int guestPnltyPoint;
  int hostRbnd;
  int guestRbnd;
  int hostOffensiveRebound;
  int guestOffensiveRebound;
  int hostDefensiveRebound;
  int guestDefensiveRebound;
  int hostAssist;
  int guestAssist;
  int hostSteal;
  int guestSteal;
  int hostBlckSht;
  int guestBlckSht;
  int hostTurnover;
  int guestTurnover;
  int hostPossessionRate;
  int guestPossessionRate;
  int hostTwoPointAttempted;
  int guestTwoPointAttempted;
  int hostTwoPointMade;
  int guestTwoPointMade;
  int hostRemainingPause;
  int guestRemainingPause;
  int hostThisFoul;
  int guestThisFoul;
  int hostFouls;
  int guestFouls;
  int hostTimeouts;
  int guestTimeouts;
  int hostScoringStreak;
  int guestScoringStreak;

  List<MatchStatusFBTechLocalModel> dataModelArr = [];

  MatchStatusBBTechModel(
      {required this.hostPoint,
      required this.guestPoint,
      required this.hostThrow,
      required this.guestThrow,
      required this.hostThrowPoint,
      required this.guestThrowPoint,
      required this.hostThrPnt,
      required this.guestThrPnt,
      required this.hostThrPntMade,
      required this.guestThrPntMade,
      required this.hostPnlty,
      required this.guestPnlty,
      required this.hostPnltyPoint,
      required this.guestPnltyPoint,
      required this.hostRbnd,
      required this.guestRbnd,
      required this.hostOffensiveRebound,
      required this.guestOffensiveRebound,
      required this.hostDefensiveRebound,
      required this.guestDefensiveRebound,
      required this.hostAssist,
      required this.guestAssist,
      required this.hostSteal,
      required this.guestSteal,
      required this.hostBlckSht,
      required this.guestBlckSht,
      required this.hostTurnover,
      required this.guestTurnover,
      required this.hostPossessionRate,
      required this.guestPossessionRate,
      required this.hostTwoPointAttempted,
      required this.guestTwoPointAttempted,
      required this.hostTwoPointMade,
      required this.guestTwoPointMade,
      required this.hostRemainingPause,
      required this.guestRemainingPause,
      required this.hostThisFoul,
      required this.guestThisFoul,
      required this.hostFouls,
      required this.guestFouls,
      required this.hostTimeouts,
      required this.guestTimeouts,
      required this.hostScoringStreak,
      required this.guestScoringStreak}) {
    _processData();
  }

  _processData() {
    if (hostThrow > 0 || guestThrow > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "投篮", team1: hostThrow, team2: guestThrow);
      dataModelArr.add(model);
    }

    if (hostThrowPoint > 0 || guestThrowPoint > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "投篮命中", team1: hostThrowPoint, team2: guestThrowPoint);
      dataModelArr.add(model);
    }

    if (hostThrPnt > 0 || guestThrPnt > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "三分", team1: hostThrPnt, team2: guestThrPnt);
      dataModelArr.add(model);
    }

    if (hostThrPntMade > 0 || guestThrPntMade > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "三分命中", team1: hostThrPntMade, team2: guestThrPntMade);
      dataModelArr.add(model);
    }

    if (hostPnlty > 0 || guestPnlty > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "罚球", team1: hostPnlty, team2: guestPnlty);
      dataModelArr.add(model);
    }

    if (hostPnltyPoint > 0 || guestPnltyPoint > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "罚球命中", team1: hostPnltyPoint, team2: guestPnltyPoint);
      dataModelArr.add(model);
    }

    if (hostRbnd > 0 || guestRbnd > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "篮板", team1: hostRbnd, team2: guestRbnd);
      dataModelArr.add(model);
    }

    if (hostOffensiveRebound > 0 || guestOffensiveRebound > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "进攻篮板",
          team1: hostOffensiveRebound,
          team2: guestOffensiveRebound);
      dataModelArr.add(model);
    }

    if (hostDefensiveRebound > 0 || guestDefensiveRebound > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "防守篮板",
          team1: hostDefensiveRebound,
          team2: guestDefensiveRebound);
      dataModelArr.add(model);
    }

    if (hostAssist > 0 || guestAssist > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "防守篮板", team1: hostAssist, team2: guestAssist);
      dataModelArr.add(model);
    }

    if (hostSteal > 0 || guestSteal > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "抢断", team1: hostSteal, team2: guestSteal);
      dataModelArr.add(model);
    }

    if (hostBlckSht > 0 || guestBlckSht > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "盖帽", team1: hostBlckSht, team2: guestBlckSht);
      dataModelArr.add(model);
    }

    if (hostTurnover > 0 || guestTurnover > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "失误", team1: hostTurnover, team2: guestTurnover);
      dataModelArr.add(model);
    }

    if (hostPossessionRate > 0 || guestPossessionRate > 0) {
      MatchStatusFBTechLocalModel model = MatchStatusFBTechLocalModel(
          title: "控球时间", team1: hostPossessionRate, team2: guestPossessionRate);
      dataModelArr.add(model);
    }
  }

  factory MatchStatusBBTechModel.fromJson(Map<String, dynamic> json) {
    return MatchStatusBBTechModel(
        hostPoint: json['hostPoint'] ?? 0,
        guestPoint: json['guestPoint'] ?? 0,
        hostThrow: json['hostThrow'] ?? 0,
        guestThrow: json['guestThrow'] ?? 0,
        hostThrowPoint: json['hostThrowPoint'] ?? 0,
        guestThrowPoint: json['guestThrowPoint'] ?? 0,
        hostThrPnt: json['hostThrPnt'] ?? 0,
        guestThrPnt: json['guestThrPnt'] ?? 0,
        hostThrPntMade: json['hostThrPntMade'] ?? 0,
        guestThrPntMade: json['guestThrPntMade'] ?? 0,
        hostPnlty: json['hostPnlty'] ?? 0,
        guestPnlty: json['guestPnlty'] ?? 0,
        hostPnltyPoint: json['hostPnltyPoint'] ?? 0,
        guestPnltyPoint: json['guestPnltyPoint'] ?? 0,
        hostRbnd: json['hostRbnd'] ?? 0,
        guestRbnd: json['guestRbnd'] ?? 0,
        hostOffensiveRebound: json['hostOffensiveRebound'] ?? 0,
        guestOffensiveRebound: json['guestOffensiveRebound'] ?? 0,
        hostDefensiveRebound: json['hostDefensiveRebound'] ?? 0,
        guestDefensiveRebound: json['guestDefensiveRebound'] ?? 0,
        hostAssist: json['hostAssist'] ?? 0,
        guestAssist: json['guestAssist'] ?? 0,
        hostSteal: json['hostSteal'] ?? 0,
        guestSteal: json['guestSteal'] ?? 0,
        hostBlckSht: json['hostBlckSht'] ?? 0,
        guestBlckSht: json['guestBlckSht'] ?? 0,
        hostTurnover: json['hostTurnover'] ?? 0,
        guestTurnover: json['guestTurnover'] ?? 0,
        hostPossessionRate: json['hostPossessionRate'] ?? 0,
        guestPossessionRate: json['guestPossessionRate'] ?? 0,
        hostTwoPointAttempted: json['hostTwoPointAttempted'] ?? 0,
        guestTwoPointAttempted: json['guestTwoPointAttempted'] ?? 0,
        hostTwoPointMade: json['hostTwoPointMade'] ?? 0,
        guestTwoPointMade: json['guestTwoPointMade'] ?? 0,
        hostRemainingPause: json['hostRemainingPause'] ?? 0,
        guestRemainingPause: json['guestRemainingPause'] ?? 0,
        hostThisFoul: json['hostThisFoul'] ?? 0,
        guestThisFoul: json['guestThisFoul'] ?? 0,
        hostFouls: json['hostFouls'] ?? 0,
        guestFouls: json['guestFouls'] ?? 0,
        hostTimeouts: json['hostTimeouts'] ?? 0,
        guestTimeouts: json['guestTimeouts'] ?? 0,
        hostScoringStreak: json['hostScoringStreak'] ?? 0,
        guestScoringStreak: json['guestScoringStreak'] ?? 0);
  }
}

class MatchStatusBBLiveLocalModel {
  List<String> titleArr;
  List<List<dynamic>> modelArr2;

  MatchStatusBBLiveLocalModel(
      {required this.titleArr, required this.modelArr2});
}
