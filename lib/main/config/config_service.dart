import 'package:wzty/app/api.dart';
import 'package:wzty/main/config/live_block_entity.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';

class ConfigService {
  static Future<void> requestUserActive(BusinessCallback<bool> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.userActive, HttpMethod.get);

    if (result.isSuccess()) {
      complete(true, result.data["activeUser"]);
    } else {
      complete(false, false);
    }
  }

  static Future<void> requestReportUserActive(
      BusinessCallback<String> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.reportUserActive, HttpMethod.post);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.msg ?? result.data;
    }
    complete(result.isSuccess(), msg);
  }

  // ----------------------  活跃用户逻辑  -----------------------

  static Future<void> requestLiveBlock(
      BusinessCallback<LiveBlockModel?> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.liveBlock, HttpMethod.get);

    if (result.isSuccess()) {
      LiveBlockModel model = LiveBlockModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestSystemNotice(
      BusinessCallback<String?> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.systemNotice, HttpMethod.get);

    if (result.isSuccess()) {
      complete(true, result.data["value"]);
    } else {
      complete(false, "");
    }
  }

  static Future<void> requestAnimateStatus(
      BusinessCallback<bool> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.animateFlag, HttpMethod.get);

    if (result.isSuccess()) {
      complete(true, result.data["showAnimation"]);
      return;
    } else {
      complete(false, false);
      return;
    }
  }

  static Future<void> requestVideoStatus(
      BusinessCallback<bool> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.videoFlag, HttpMethod.get);

    if (result.isSuccess()) {
      complete(true, result.data["showVideo"]);
      return;
    } else {
      complete(false, false);
      return;
    }
  }

  static Future<void> requestLiveStatus(BusinessCallback<bool> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.liveFlag, HttpMethod.get);

    if (result.isSuccess()) {
      complete(true, result.data["showLive"]);
    } else {
      complete(false, false);
    }
  }

  static Future<void> requestConfigInfo(
      BusinessCallback<String?> complete) async {
    Map<String, dynamic> params = {
      "groupKey": "1",
    };

    HttpResultBean result = await HttpManager.request(
        ConfigApi.configInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      String config = "";
      for (Map<String, dynamic> map in result.data) {
        if (map["type"] == "3") {
          config = map["value"];
          break;
        }
      }
      complete(true, config);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestChannelInfo(
      BusinessCallback<Map?> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.channelInfo, HttpMethod.post);

    if (result.isSuccess() && result.data is Map) {
      complete(true, result.data);
    } else {
      complete(false, null);
    }
  }
}
