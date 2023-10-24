import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';

class MatchDetailService {
  // -------------------------------------------

  static Future<void> requestMatchDetail(
      int matchId, BusinessCallback<MatchDetailModel?> complete) async {
    Map<String, dynamic> params = {
      "id": matchId,
    };


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
}