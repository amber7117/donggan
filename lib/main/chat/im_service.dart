import 'package:wzty/app/api.dart';
import 'package:wzty/main/chat/im_msg_filter_entity.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';

class IMService {
  static Future<String?> requestInitInfo() async {
    HttpResultBean result =
        await HttpManager.request(IMApi.initInfo, HttpMethod.get);

    if (result.isSuccess()) {
      return result.data["appId"];
    } else {
      return null;
    }
  }

  static Future<String?> requestToken() async {
    String userId = await UserManager.instance.obtainUseridOrDeviceid();
    Map<String, dynamic> params = {};
    if (UserManager.instance.isLogin()) {
      params["isLogin"] = 1;
      params["userId"] = userId;
    } else {
      params["isLogin"] = 0;
      params["userId"] = userId.replaceAll("-", "");
    }
    HttpResultBean result = await HttpManager.request(
        IMApi.tokenInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      return (result as String);
    } else {
      return null;
    }
  }

  static Future<IMMsgFilterModel?> requestMsgVerify(String content,
      {String enumType = "LIVE_CHAT_ROOM"}) async {
    String userId = await UserManager.instance.obtainUseridOrDeviceid();
    Map<String, dynamic> params = {
      "content": content,
      "userId": userId,
      "enumItem": enumType
    };
    HttpResultBean result = await HttpManager.request(
        IMApi.tokenInfo, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      IMMsgFilterModel model = IMMsgFilterModel.fromJson(result.data);
      return model;
    } else {
      return null;
    }
  }
}
