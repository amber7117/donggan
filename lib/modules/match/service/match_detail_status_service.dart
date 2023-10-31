import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_score_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_tech_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';

class MatchDetailStatusService {
  // -------------------------------------------

  static Future<void> requestFbTechData(
      int matchId, BusinessCallback<MatchStatusFBTechModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.fbTech, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchStatusFBTechModel model =
          MatchStatusFBTechModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestFbEventData(int matchId,
      BusinessCallback<List<MatchStatusFBEventModel>> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.fbEvent, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<MatchStatusFBEventModel> retList = tmpList
          .map((dataMap) => MatchStatusFBEventModel.fromJson(dataMap))
          .toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
    return;
  }

  static Future<void> requestLiveData(SportType sportType, int matchId,
      BusinessCallback<List<MatchStatusFBLiveModel>> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        sportType == SportType.football
            ? MatchStatusApi.fbLive
            : MatchStatusApi.bbLive,
        HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<MatchStatusFBLiveModel> retList = tmpList
          .map((dataMap) => MatchStatusFBLiveModel.fromJson(dataMap))
          .toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
    return;
  }

  static Future<void> requestLive2Data(int matchId,
      BusinessCallback<List<MatchStatusFBEventModel>> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.live2, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["events"];
      List<MatchStatusFBEventModel> retList = tmpList
          .map((dataMap) => MatchStatusFBEventModel.fromJson(dataMap))
          .toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
    return;
  }

  static Future<void> requestBBScoreData(
      int matchId, BusinessCallback<MatchStatusBBScoreModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.bbScore, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchStatusBBScoreModel model =
          MatchStatusBBScoreModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestBBTechData(
      int matchId, BusinessCallback<MatchStatusBBTechModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.bbTech, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchStatusBBTechModel model =
          MatchStatusBBTechModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }
}
