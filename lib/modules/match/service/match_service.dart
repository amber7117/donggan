import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/match/entity/match_entity.dart';

class MatchService {

  static Future<void> requestMatchList(
      Map<String, dynamic> params, BusinessCallback<MatchModel?> complete) async {
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
}