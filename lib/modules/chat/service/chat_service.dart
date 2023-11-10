import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/chat/entity/chat_user_info_entity.dart';

class ChatService {
  static Future<HttpResultBean> requestUserChatInfo(String roomId,
      String userId, BusinessCallback<dynamic> complete) async {
    Map<String, dynamic> params = {"roomId": roomId, "userId": userId};

    HttpResultBean result = await HttpManager.request(
        ChatApi.userChatInfo, HttpMethod.get,
        params: params);
    if (result.isSuccess()) {
      ChatUserInfo chatInfo = ChatUserInfo.fromJson(result.data);

      complete(true, chatInfo);
    } else {
      complete(false, result.msg ?? result.data);
    }
    return result;
  }

  static Future<void> requestRecallMsg(Map<String, dynamic> params, bool allMsg,
      BusinessCallback<String> complete) async {
    HttpResultBean result = await HttpManager.request(
        allMsg ? ChatApi.recallMsgAll : ChatApi.recallMsg, HttpMethod.get,
        params: params);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.msg ?? result.data;
    }
    complete(result.isSuccess(), msg);
  }

  static Future<void> requestAdmainOperat(
      Map<String, dynamic> params, BusinessCallback<String> complete) async {
    HttpResultBean result = await HttpManager.request(
        ChatApi.admainOperate, HttpMethod.get,
        params: params);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.msg ?? result.data;
    }
    complete(result.isSuccess(), msg);
  }
}
