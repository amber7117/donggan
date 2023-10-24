import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/entity/match_anchor_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';

class MatchDetailService {
  // -------------------------------------------

  static Future<void> requestMatchDetail(
      int matchId, BusinessCallback<MatchDetailModel?> complete) async {
    Map<String, dynamic> params = {
      "id": matchId,
    };
    if (UserManager.instance.isLogin()) {
      params["userId"] = UserManager.instance.uid;
    }

    HttpResultBean result = await HttpManager.request(
        MatchApi.matchDetail, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchDetailModel model = MatchDetailModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
  }

  // -------------------------------------------

  /// 赛事详情主播信息
  static Future<void> requestMatchAnchor(
      int matchId, BusinessCallback<MatchAnchorModel?> complete) async {
    Map<String, dynamic> params = {
      "matchId": matchId,
    };

    HttpResultBean result = await HttpManager.request(
        MatchApi.matchAnchor, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchAnchorModel model = MatchAnchorModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
  }

  // -------------------------------------------


  // -------------------------------------------

  
}
