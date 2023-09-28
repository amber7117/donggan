import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';

class MeService {
  static Future<void> requestUserInfo(
      String uid, BusinessSuccess<String> complete) async {
    String path = MeApi.userInfo.replaceAll(apiPlaceholder, uid);

    HttpResultBean result = await HttpManager.request(path, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }

  static Future<void> requestFollowList(
      BusinessSuccess<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(MeApi.followList, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }

  static Future<void> requestFansList(BusinessSuccess<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(MeApi.fansList, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }

  static Future<void> requestUserFocus(
      String uid, bool isFocus, BusinessSuccess<String> complete) async {
    String path;
    if (isFocus) {
      path = MeApi.userFocus.replaceAll(apiPlaceholder, uid);
    } else {
      path = MeApi.userFocusCancel.replaceAll(apiPlaceholder, uid);
    }

    HttpResultBean result = await HttpManager.request(path, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }

  static Future<void> modifyUserInfo(BusinessSuccess<String> complete) async {
    String path = MeApi.modifyUserInfo
        .replaceAll(apiPlaceholder, UserManager.instance.uid);

    HttpResultBean result = await HttpManager.request(path, HttpMethod.get);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }
}
