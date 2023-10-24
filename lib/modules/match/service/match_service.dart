import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/entity/match_calendar_entity.dart';
import 'package:wzty/modules/match/entity/match_entity.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';

class MatchService {
  static Future<void> requestMatchList(Map<String, dynamic> params,
      BusinessCallback<MatchModel?> complete) async {
    HttpResultBean result = await HttpManager.request(
        MatchApi.matchList, HttpMethod.post,
        params: params);

    if (result.isSuccess()) {
      MatchModel model = MatchModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestMatchListAttr(SportType sportType,
      BusinessCallback<List<MatchListModel>> complete) async {
    String userId = await UserManager.instance.obtainUseridOrDeviceid();
    Map<String, dynamic> params = {
      "sportType": sportType.value,
      "matchType": sportType.value,
      "userId": userId
    };

    HttpResultBean result = await HttpManager.request(
        MatchApi.matchListAtt, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List retList = result.data;
      List<MatchListModel> matchList = retList
          .map((dataMap) => MatchListModel.fromJson(dataMap)..focus = true)
          .toList();
      complete(true, matchList);
    } else {
      complete(false, []);
    }
  }

  static Future<void> requestMatchCollect(SportType sportType, int matchId,
      bool isAdd, BusinessCallback<String> complete) async {
    String userId = await UserManager.instance.obtainUseridOrDeviceid();
    Map<String, dynamic> params = {
      "matchType": sportType.value,
      "matchId": matchId,
      "userId": userId
    };

    HttpResultBean result = await HttpManager.request(
        isAdd ? MatchApi.matchCollect : MatchApi.matchCollectCancel,
        HttpMethod.post,
        params: params);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  static Future<void> requestMatchBook(int matchId,
      bool isAdd, BusinessCallback<String> complete) async {
    String userId = await UserManager.instance.obtainUseridOrDeviceid();
    Map<String, dynamic> params = {
       "matchId": matchId, "userId": userId
    };

    HttpResultBean result = await HttpManager.request(
        isAdd ? MatchApi.matchBook : MatchApi.matchBookCancel,
        HttpMethod.post,
        params: params);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  /// 主播热门赛事
  static Future<void> requestHotMatchList(
      BusinessCallback<List<MatchListModel>> complete) async {
    HttpResultBean result =
        await HttpManager.request(MatchApi.hotMatchList, HttpMethod.get);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<MatchListModel> retList =
          tmpList.map((dataMap) => MatchListModel.fromJson(dataMap)).toList();
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }

  /// 主播预告
  static Future<void> requestAnchorCalendarMatch(
      int anchorId, BusinessCallback<List<MatchCalendarEntity>> complete) async {
    Map<String, dynamic> params = {
      "anchorId": anchorId,
    };

    HttpResultBean result = await HttpManager.request(
        MatchApi.anchorOrderMatch, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<MatchCalendarEntity> retList =
          tmpList.map((dataMap) => MatchCalendarEntity.fromJson(dataMap)).toList();
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }
}
