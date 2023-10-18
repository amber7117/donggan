import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/anchor/entity/anchor_video_entity.dart';

class AnchorService {
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
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }

  static Future<void> requestTypeList(LiveSportType type,
      BusinessCallback<List<AnchorListModel>> complete) async {
    Map<String, dynamic> params = {"liveType": type.value};

    HttpResultBean result = await HttpManager.request(
        AnchorApi.typeList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      if (result.data is List) {
        List tmpList = result.data;
        List<AnchorListModel> retList = tmpList
            .map((dataMap) => AnchorListModel.fromJson(dataMap))
            .toList();
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
      List<AnchorVideoModel> retList =
          tmpList.map((dataMap) => AnchorVideoModel.fromJson(dataMap)).toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
  }
}
