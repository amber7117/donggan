import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/match/entity/match_filter_entity.dart';

class MatchFilterService {
  static Future<void> requestFBAllData(MatchFilterType type, MatchStatus status,
      String dateStr, BusinessCallback<MatchFilterModel?> complete) async {
    Map<String, dynamic> params = {
      "typeId": type.value,
    };
    params["status"] = matchStatusToServerValue(status);
    if (dateStr.isNotEmpty) {
      params["date"] = dateStr;
    }

    HttpResultBean result = await HttpManager.request(
        MatchApi.matchFilter, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchFilterModel model = MatchFilterModel();

      model.totalCount = result.data['totalCount'] ?? 0;

      List keyAllTmp = (result.data as Map).keys.toList();
      keyAllTmp.sort((s1, s2) => s1.toLowerCase().compareTo(s2.toLowerCase()));

      List keyAll = keyAllTmp.where((key) => key.length <= 1).toList();

      List<String> titleArr = [];
      List<List<MatchFilterItemModel>> modelArrArr = [];

      for (String key in keyAll) {
        List<dynamic> arrayValue = result.data[key] ?? [];
        if (arrayValue.isEmpty) {
          continue;
        }

        List<MatchFilterItemModel> modelArr =
            arrayValue.map((e) => MatchFilterItemModel.fromJson(e)).toList();

        titleArr.add(key);
        modelArrArr.add(modelArr);
      }

      model.titleArr = titleArr;
      model.moderArrArr = modelArrArr;

      complete(true, model);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestFBHotData(MatchFilterType type,
      BusinessCallback<MatchFilterModel?> complete) async {
    Map<String, dynamic> params = {
      "typeId": type.value,
    };

    HttpResultBean result = await HttpManager.request(
        MatchApi.matchFilter, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchFilterModel model = MatchFilterModel();
      model.totalCount = result.data["totalCount"];

      List retList = result.data["tournamentList"];
      List<MatchFilterItemModel> itemList = retList
          .map((dataMap) => MatchFilterItemModel.fromJson(dataMap))
          .toList();
      model.hotArr = itemList;

      complete(true, model);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestBBAllData(MatchFilterType type, MatchStatus status,
      String dateStr, BusinessCallback<MatchFilterModel?> complete) async {
    Map<String, dynamic> params = {
      "typeId": type.value,
    };
    params["status"] = matchStatusToServerValue(status);
    if (dateStr.isNotEmpty) {
      params["date"] = dateStr;
    }

    HttpResultBean result = await HttpManager.request(
        MatchApi.matchFilter, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      MatchFilterModel model = MatchFilterModel();
      model.totalCount = result.data["totalCount"];

      List retList = result.data["tournamentList"];
      List<MatchFilterItemModel> itemList = retList
          .map((dataMap) => MatchFilterItemModel.fromJson(dataMap))
          .toList();
      model.hotArr = itemList;

      complete(true, model);
    } else {
      complete(false, null);
    }
  }
}
