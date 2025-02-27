import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/anchor/entity/anchor_category_entity.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/anchor/entity/anchor_video_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_manager.dart';

class AnchorService {
  static Future<void> requestCategoryInfo(
      BusinessCallback<List<AnchorCategoryModel>> complete) async {
    HttpResultBean result =
        await HttpManager.request(AnchorApi.categoryInfo, HttpMethod.get);

    if (result.isSuccess()) {
      List tmpList = result.data["liveGroupList"];
      List<AnchorCategoryModel> retList = tmpList
          .map((dataMap) => AnchorCategoryModel.fromJson(dataMap))
          .toList();

      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }

  static Future<void> requestHotList(
      int page, BusinessCallback<List<AnchorListModel>> complete) async {
    Map<String, dynamic> params = {"pageNum": 1, "pageSize": pageSize100};

    HttpResultBean result = await HttpManager.request(
        AnchorApi.hotList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["list"];
      List<AnchorListModel> retList =
          tmpList.map((dataMap) => AnchorListModel.fromJson(dataMap)).toList();

      retList = await removeBlockData(retList);

      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }

  static Future<void> requestTypeList(int type,
      BusinessCallback<List<AnchorListModel>> complete) async {
    Map<String, dynamic> params = {"liveType": type};

    HttpResultBean result = await HttpManager.request(
        AnchorApi.typeList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      if (result.data is List) {
        List tmpList = result.data;
        List<AnchorListModel> retList = tmpList
            .map((dataMap) => AnchorListModel.fromJson(dataMap))
            .toList();

        retList = await removeBlockData(retList);

        complete(true, retList);
      } else {
        complete(true, []);
      }

      return;
    } else {
      complete(false, []);
      return;
    }
  }

  static Future<List<AnchorListModel>> removeBlockData(
      List<AnchorListModel> listArr) async {
    List<UserBlockEntity> blockAuthorArr =
        await UserBlockManger.instance.obtainBlockData();
    if (blockAuthorArr.isEmpty) {
      return listArr;
    }

    List<AnchorListModel> arrTmp = [];
    for (var model in listArr) {
      if (!UserBlockManger.instance.getBlockStatus(userId: model.anchorId)) {
        arrTmp.add(model);
      }
    }

    return arrTmp;
  }

  static Future<void> requestDetailBasicInfo(
      int anchorId, BusinessCallback<AnchorDetailModel?> complete) async {
    Map<String, dynamic> params = {"anchorId": anchorId};

    if (UserManager.instance.isLogin()) {
      params["currentUserId"] = UserManager.instance.uid;
    }

    HttpResultBean result = await HttpManager.request(
        AnchorApi.detailBasicInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      AnchorDetailModel model = AnchorDetailModel.fromJson(result.data);
      complete(true, model);
      return;
    } else {
      complete(false, null);
      return;
    }
  }

  static Future<void> requestDetailPlayInfo(
      int anchorId, BusinessCallback<AnchorDetailModel?> complete) async {
    Map<String, dynamic> params = {"anchorId": anchorId};

    if (UserManager.instance.isLogin()) {
      params["currentUserId"] = UserManager.instance.uid;
    }

    HttpResultBean result = await HttpManager.request(
        AnchorApi.detailPlayInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      AnchorDetailModel model = AnchorDetailModel.fromJson(result.data);
      complete(true, model);
      return;
    } else {
      complete(false, null);
      return;
    }
  }

  static Future<void> requestPlaybackList(int anchorId, int page,
      BusinessCallback<List<AnchorVideoModel>> complete) async {
    Map<String, dynamic> params = {
      "anchorId": anchorId,
      "pageNum": page,
      "pageSize": pageSize100,
    };

    HttpResultBean result = await HttpManager.request(
        AnchorApi.playbackList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["list"];

      List<AnchorVideoModel> retList = [];
      for (Map<String, dynamic> map in tmpList) {
        for (List list in map.values) {
          List<AnchorVideoModel> videoList = list
              .map((dataMap) => AnchorVideoModel.fromJson(dataMap))
              .toList();
          retList.addAll(videoList);
        }
      }
      complete(true, retList);
    } else {
      complete(false, []);
    }
  }

  static Future<void> requestPlaybackInfo(int anchorId, int recordId,
      BusinessCallback<AnchorRecordModel?> complete) async {
    Map<String, dynamic> params = {"anchorId": anchorId, "recordId": recordId};

    if (UserManager.instance.isLogin()) {
      params["currentUserId"] = UserManager.instance.uid;
    }

    HttpResultBean result = await HttpManager.request(
        AnchorApi.playbackInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      Map<String, dynamic> data = result.data["roomRecord"];

      AnchorRecordModel model = AnchorRecordModel.fromJson(data);
      complete(true, model);
      return;
    } else {
      complete(false, null);
    }
  }
}
