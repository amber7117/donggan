import 'package:wzty/app/api.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/search/entity/search_entity.dart';

class SearchService {
  static Future<void> requestSearchData(
      String keyword, BusinessCallback<SearchResultModel?> complete) async {
    Map<String, dynamic> params = {"keyword": keyword, "searchType": 1};

    HttpResultBean result = await HttpManager.request(
        AnchorApi.searchData, HttpMethod.post,
        params: params);

    if (result.isSuccess()) {
      SearchResultModel model = SearchResultModel.fromJson(result.data);
      if (!ConfigManager.instance.liveOk) {
        model.anchors = [];
      } else if (!ConfigManager.instance.activeUser) {
        List<AnchorListModel> tmpArr = [];
        for (var tmp in model.anchors) {
          if (tmp.isGreenLive.isTrue()) {
            tmpArr.add(tmp);
          }
        }
        model.anchors = tmpArr;
      }
      complete(true, model);
    } else {
      complete(false, null);
    }
  }
}
