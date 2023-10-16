import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/anchor/entity/live_list_entity.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';

class AnchorService {
  static Future<void> requestHotMatchList(
      BusinessCallback<List<MatchListModel>> complete) async {
    HttpResultBean result =
        await HttpManager.request(AnchorApi.hotMatchList, HttpMethod.get);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<MatchListModel> retList =
          tmpList.map((dataMap) => MatchListModel.fromJson(dataMap)).toList();
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }

  static Future<void> requestHotList(
      int page, BusinessCallback<List<LiveListModel>> complete) async {
    Map<String, dynamic> params = {"pageNum": 1, "pageSize": pageSize100};

    HttpResultBean result = await HttpManager.request(
        AnchorApi.hotList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["list"];
      List<LiveListModel> retList =
          tmpList.map((dataMap) => LiveListModel.fromJson(dataMap)).toList();
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }

  static Future<void> requestTypeList(LiveSportType type,
      BusinessCallback<List<LiveListModel>> complete) async {
    Map<String, dynamic> params = {"liveType": type.value};

    HttpResultBean result = await HttpManager.request(
        AnchorApi.typeList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<LiveListModel> retList =
          tmpList.map((dataMap) => LiveListModel.fromJson(dataMap)).toList();
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }
}
