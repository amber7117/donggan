import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/entity/match_entity.dart';
import 'package:wzty/modules/match/entity/match_info_entity.dart';

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
      BusinessCallback<List<MatchInfoModel>> complete) async {
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
      List<MatchInfoModel> matchList = retList
          .map((dataMap) => MatchInfoModel.fromJson(dataMap)..focus = true)
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
}
