import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/me/entity/user_info_entity.dart';

enum FollowListType {
  anchor(value: 2),
  author(value: 4);

  const FollowListType({required this.value});

  final int value;
}

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

  static Future<void> requestFollowList(FollowListType type,
      BusinessCallback<List<UserInfoEntity>> complete) async {
    Map<String, dynamic> params = {
      "pageNum": 1,
      "pageSize": pageSize,
      "focusUserId": UserManager.instance.uid,
      "type": type.value
    };

    HttpResultBean result = await HttpManager.request(
        MeApi.followList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["list"];
      List<UserInfoEntity> retList =
          tmpList.map((dataMap) => UserInfoEntity.fromJson(dataMap)).toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
  }

  static Future<void> requestFansList(
      BusinessCallback<List<UserInfoEntity>> complete) async {
    Map<String, dynamic> params = {
      "pageNum": 1,
      "pageSize": pageSize,
      "userId": UserManager.instance.uid,
    };

    HttpResultBean result = await HttpManager.request(
        MeApi.fansList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["list"];
      List<UserInfoEntity> retList =
          tmpList.map((dataMap) => UserInfoEntity.fromJson(dataMap)).toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
  }

  static Future<HttpResultBean> requestUserFocus(
      String uid, bool isFocus) async {
    String path;
    if (isFocus) {
      path = MeApi.userFocus.replaceAll(apiPlaceholder, uid);
    } else {
      path = MeApi.userFocusCancel.replaceAll(apiPlaceholder, uid);
    }

    HttpResultBean result = await HttpManager.request(path, HttpMethod.post);

    return result;
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
