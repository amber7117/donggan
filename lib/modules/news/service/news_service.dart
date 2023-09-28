import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';

class NewsService {
  static Future<void> requestNewsLabel(
      String uid, BusinessSuccess<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(NewsApi.label, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }

  static Future<void> requestHotList(
      String uid, BusinessSuccess<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(NewsApi.hotList, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }

  static Future<void> requestTypeList(
      String uid, BusinessSuccess<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(NewsApi.typeList, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }

  static Future<void> requestDetail(
      String uid, BusinessSuccess<String> complete) async {
    String path = NewsApi.detail.replaceAll(apiPlaceholder, uid);
    HttpResultBean result = await HttpManager.request(path, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }
}
