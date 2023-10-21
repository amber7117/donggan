import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
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
      complete(true, model);
    } else {
      complete(false, null);
    }
  }
}
