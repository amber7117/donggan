import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/me/entity/sys_msg_entity.dart';
import 'package:wzty/modules/me/entity/user_info_entity.dart';
import 'package:wzty/modules/news/entity/news_list_entity.dart';

enum FollowListType {
  anchor(value: 2),
  author(value: 4);

  const FollowListType({required this.value});

  final int value;
}

class MeService {
  static Future<void> requestUserInfo(
      String uid, BusinessCallback<UserInfoEntity?> complete) async {
    String path = MeApi.userInfo2.replaceAll(apiPlaceholder, uid);

    HttpResultBean result = await HttpManager.request(path, HttpMethod.get);

    if (result.isSuccess()) {
      UserInfoEntity model = UserInfoEntity.fromJson(result.data);
      complete(true, model);
      return;
    } else {
      complete(false, null);
      return;
    }
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

  static Future<void> requestModifyUserInfo(
      Map<String, dynamic> params, BusinessCallback<String> complete) async {
    String path = MeApi.modifyUserInfo
        .replaceAll(apiPlaceholder, UserManager.instance.uid);

    HttpResultBean result =
        await HttpManager.request(path, HttpMethod.get, params: params);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  static Future<void> requestModifyUserMobile(
      Map<String, dynamic> params, BusinessCallback<String> complete) async {
    HttpResultBean result = await HttpManager.request(
        MeApi.modifyUserMobile, HttpMethod.post,
        params: params);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  static Future<void> requestModifyUserPwd(
      Map<String, dynamic> params, BusinessCallback<String> complete) async {
    HttpResultBean result = await HttpManager.request(
        MeApi.modifyUserPwd, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  static Future<void> requestAvatarList(
      BusinessCallback<List<String>> complete) async {
    HttpResultBean result =
        await HttpManager.request(MeApi.avatarList, HttpMethod.get);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<String> retList = tmpList.map((data) => data.toString()).toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
  }

  static Future<void> requestSysMsgList(
      BusinessCallback<List<SysMsgModel>> complete) async {
    HttpResultBean result =
        await HttpManager.request(MeApi.sysMsgList, HttpMethod.get);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<SysMsgModel> retList =
          tmpList.map((dataMap) => SysMsgModel.fromJson(dataMap)).toList();
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }

  static Future<void> requestFootprintData(
      int page, BusinessCallback<List<NewsListModel>> complete) async {
    Map<String, dynamic> params = {
      "pageNum": page,
      "pageSize": pageSize,
    };

    HttpResultBean result = await HttpManager.request(
        MeApi.footprint, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["list"];
      List<NewsListModel> retList =
          tmpList.map((dataMap) => NewsListModel.fromJson(dataMap)).toList();
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }

  static Future<void> requestCancelAccount(
      Map<String, dynamic> params, BusinessCallback<String> complete) async {
    HttpResultBean result = await HttpManager.request(
        MeApi.cancelAccount, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.msg ?? result.data);
    }
  }
}
