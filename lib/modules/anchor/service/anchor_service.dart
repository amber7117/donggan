import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/anchor/entity/live_list_entity.dart';

class AnchorService {
  static Future<void> requestMatchList(Map<String, dynamic> params,
      BusinessCallback<LiveListModel?> complete) async {
    HttpResultBean result = await HttpManager.request(
        MatchApi.matchList, HttpMethod.post,
        params: params);

    if (result.isSuccess()) {
      LiveListModel model = LiveListModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
  }
}
