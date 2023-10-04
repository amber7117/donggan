import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';

class NewsService {
  static Future<void> requestNewsLabel(
      String uid, BusinessCallback<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(NewsApi.label, HttpMethod.post);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.data ?? result.msg);
    }
  }

  static Future<void> requestHotList(
      String uid, BusinessCallback<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(NewsApi.hotList, HttpMethod.post);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.data ?? result.msg);
    }
  }

  static Future<void> requestTypeList(
      String uid, BusinessCallback<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(NewsApi.typeList, HttpMethod.post);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.data ?? result.msg);
    }
  }

  static Future<void> requestDetail(
      String uid, BusinessCallback<String> complete) async {
    String path = NewsApi.detail.replaceAll(apiPlaceholder, uid);
    HttpResultBean result = await HttpManager.request(path, HttpMethod.post);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.data ?? result.msg);
    }
  }
}
