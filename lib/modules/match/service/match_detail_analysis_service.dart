import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';

class MatchDetailAnalysisService {
  // -------------------------------------------

  static Future<void> requestRankData(SportType sportType, int matchId,
      BusinessCallback<List<MatchAnalysisRankTeamModel>> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        sportType == SportType.football
            ? MatchAnalysisApi.fbRank
            : MatchAnalysisApi.bbRank,
        HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["all"] ?? [];
      List<MatchAnalysisRankTeamModel> retList = tmpList
          .map((dataMap) => MatchAnalysisRankTeamModel.fromJson(dataMap))
          .toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
    return;
  }

  static Future<void> requestHistoryData(
      int matchId,
      int hostTeamId,
      int guestTeamId,
      bool isAll,
      BusinessCallback<MatchAnalysisHistoryModel?> complete,
      {String leagueId = ""}) async {
    //主客就是YES，全部就是NO
    Map<String, dynamic> params = {
      "matchId": matchId,
      "hostTeamId": hostTeamId,
      "guestTeamId": guestTeamId,
      "size": 6,
      "fixed": isAll ? 0 : 1
    };

    if (leagueId.isNotEmpty) {
      //同赛事
      params["leagueId"] = leagueId;
    }
    HttpResultBean result = await HttpManager.request(
        MatchAnalysisApi.history, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchAnalysisHistoryModel model =
          MatchAnalysisHistoryModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestRecentData(
      SportType sportType,
      int matchId,
      int teamId,
      bool isAll,
      BusinessCallback<MatchAnalysisHistoryModel?> complete,
      {String leagueId = ""}) async {
    Map<String, dynamic> params = {
      "matchId": matchId,
      "teamId": teamId,
      "size": 6,
      "side": isAll ? "all" : "host",
    };
    if (leagueId.isNotEmpty) {
      //同赛事
      params["leagueId"] = leagueId;
    }
    HttpResultBean result = await HttpManager.request(
        sportType == SportType.football
            ? MatchAnalysisApi.fbRecent
            : MatchAnalysisApi.bbRecent,
        HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchAnalysisHistoryModel model =
          MatchAnalysisHistoryModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestFutureData(int matchId, int teamId,
      BusinessCallback<List<MatchAnalysisMatchModel>> complete) async {
    Map<String, dynamic> params = {
      "matchId": matchId,
      "teamId": teamId,
    };

    HttpResultBean result = await HttpManager.request(
        MatchAnalysisApi.future, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["matches"];
      List<MatchAnalysisMatchModel> retList = tmpList
          .map((dataMap) => MatchAnalysisMatchModel.fromJson(dataMap))
          .toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
    return;
  }
}
