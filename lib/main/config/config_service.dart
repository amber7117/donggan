import 'package:wzty/app/api.dart';
import 'package:wzty/main/config/live_block_entity.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';

class ConfigService {
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
      BusinessCallback<bool?> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.animateFlag, HttpMethod.get);

    if (result.isSuccess()) {
      complete(true, result.data["showAnimation"]);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestVideoStatus(
      BusinessCallback<bool?> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.videoFlag, HttpMethod.get);

    if (result.isSuccess()) {
      complete(true, result.data["showVideo"]);
    } else {
      complete(false, null);
    }
  }

  static Future<void> requestLiveStatus(
      BusinessCallback<bool?> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.liveFlag, HttpMethod.get);

    if (result.isSuccess()) {
      complete(true, result.data["showLive"]);
    } else {
      complete(false, null);
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
      BusinessCallback<String?> complete) async {
    HttpResultBean result =
        await HttpManager.request(ConfigApi.channelInfo, HttpMethod.post);

    if (result.isSuccess()) {
      complete(true, (result.data is Map) ? result.data["echatUrl"] : "");
    } else {
      complete(false, null);
    }
  }
}
