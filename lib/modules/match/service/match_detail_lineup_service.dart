import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_bb_model.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_info_model.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_model.dart';

class MatchDetailLineupService {
  // -------------------------------------------

  static Future<void> requestBBLineup(int matchId, String hostTeamName,
      BusinessCallback<MatchLineupBBModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId, "aggr": 1};

    HttpResultBean result = await HttpManager.request(
        MatchLineupApi.bbLineup, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      final retDic = result.data;

      final keyArray = retDic.keys.toList();

      if (keyArray.length > 1) {
        String hostTeamKey = keyArray.first;
        Map<String, dynamic> hostTeamData = retDic[hostTeamKey];

        MatchLineupBBTeamModel hostTeam =
            MatchLineupBBTeamModel.fromJson(hostTeamData);

        String guestTeamKey = keyArray.last;
        Map<String, dynamic> guestTeamData = retDic[guestTeamKey];

        MatchLineupBBTeamModel guestTeam =
            MatchLineupBBTeamModel.fromJson(guestTeamData);

        MatchLineupBBModel modelRet;

        if (hostTeam.teamName.contains(hostTeamName)) {
          modelRet =
              MatchLineupBBModel(hostTeam: hostTeam, guestTeam: guestTeam);
        } else {
          modelRet =
              MatchLineupBBModel(hostTeam: guestTeam, guestTeam: hostTeam);
        }

        modelRet.hostDataArr2 =
            MatchLineupBBModel.obtainDataArr2(modelRet.hostTeam.playerStats);
        modelRet.guestDataArr2 =
            MatchLineupBBModel.obtainDataArr2(modelRet.guestTeam.playerStats);

        complete(true, modelRet);
      } else {
        complete(true, null);
      }
    } else {
      complete(false, null);
    }
  }

  // -------------------------------------------

  static Future<void> requestFBLineup(
      int matchId, BusinessCallback<MatchLineupFBModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchLineupApi.fbLineup, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchLineupFBModel model = MatchLineupFBModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestFBPlayerInfo(int matchId, int teamId, int playerId,
      BusinessCallback<dynamic> complete) async {
    Map<String, dynamic> params = {
      "matchId": matchId,
      "teamId": teamId,
      "playerId": playerId,
    };

    HttpResultBean result = await HttpManager.request(
        MatchLineupApi.playerInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess() && result.data is Map) {
      MatchLineupFBPlayerInfoModel model =
          MatchLineupFBPlayerInfoModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  static Future<void> requestFBCoachInfo(int matchId, int teamId, int coachId,
      BusinessCallback<MatchLineupFBCoachInfoModel?> complete) async {
    Map<String, dynamic> params = {
      "matchId": matchId,
      "teamId": teamId,
      "coachId": coachId,
    };

    HttpResultBean result = await HttpManager.request(
        MatchLineupApi.coachInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchLineupFBCoachInfoModel model =
          MatchLineupFBCoachInfoModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestFBRefereeInfo(int matchId, int refereeId,
      BusinessCallback<MatchLineupFBRefereeInfoModel?> complete) async {
    Map<String, dynamic> params = {
      "matchId": matchId,
      "teamId": "",
      "refereeId": refereeId
    };

    HttpResultBean result = await HttpManager.request(
        MatchLineupApi.refereeInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchLineupFBRefereeInfoModel model =
          MatchLineupFBRefereeInfoModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
  }
}
