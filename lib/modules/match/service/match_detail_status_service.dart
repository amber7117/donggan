import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';

class MatchDetailStatusService {
  // -------------------------------------------

  static Future<void> requestFbTechData(
      int matchId, BusinessCallback<MatchDetailModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.fbTech, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchDetailModel model = MatchDetailModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestFbEventData(
      int matchId, BusinessCallback<MatchDetailModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.fbEvent, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchDetailModel model = MatchDetailModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestLiveData(int matchId, SportType sportType,
      BusinessCallback<MatchDetailModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        sportType == SportType.football
            ? MatchStatusApi.fbLive
            : MatchStatusApi.bbLive,
        HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchDetailModel model = MatchDetailModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestLive2Data(
      int matchId, BusinessCallback<MatchDetailModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.live2, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchDetailModel model = MatchDetailModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestBBScoreData(
      int matchId, BusinessCallback<MatchDetailModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.bbScore, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchDetailModel model = MatchDetailModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestBBTechData(
      int matchId, BusinessCallback<MatchDetailModel?> complete) async {
    Map<String, dynamic> params = {"matchId": matchId};

    HttpResultBean result = await HttpManager.request(
        MatchStatusApi.bbTech, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchDetailModel model = MatchDetailModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }
}
