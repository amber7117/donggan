import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/main/im/im_msg_filter_entity.dart';
import 'package:wzty/main/im/im_service.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/chat/entity/chat_entity.dart';
import 'package:wzty/modules/chat/entity/chat_user_info_entity.dart';
import 'package:wzty/modules/chat/service/chat_service.dart';
import 'package:wzty/utils/toast_utils.dart';

// mixin ChatPageMixin<T extends StatefulWidget> on State<T> {
// }

mixin ChatPageMixin {
  // -------------------------------------------

  String getRoomId();
  String getChatRoomId();

  // -------------------------------------------

  void requestDeleteMsg(ChatMsgModel msg, VoidCallback callback) {
    if (!UserManager.instance.isLogin()) {
      return;
    }

    final params = {
      "chatRoomId": getChatRoomId(),
      "adminId": UserManager.instance.uid,
      "userId": msg.userId,
      "msgId": msg.messageUId,
      "sentTime": msg.sendTime,
    };

    ToastUtils.showLoading();
    ChatService.requestRecallMsg(params, false, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        callback();
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  void requestForbidUser(ChatUserInfo info) {
    if (!UserManager.instance.isLogin()) {
      return;
    }

    final isMute = !info.isMute.isTrue();
    final params = {
      "roomId": getRoomId(),
      "chatId": getChatRoomId(),
      "operatorType": isMute ? 4 : 5,
      "operatorUserId": UserManager.instance.uid,
      "setUserId": info.userId,
      "time": 60,
    };

    ToastUtils.showLoading();
    ChatService.requestAdmainOperat(params, (success, result) {
      if (success) {
        ToastUtils.showSuccess(isMute ? "用户禁言成功" : "用户解除禁言成功");
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  void requestKickoutUser(ChatUserInfo info) {
    if (!UserManager.instance.isLogin()) {
      return;
    }

    final params = {
      "roomId": getRoomId(),
      "chatId": getChatRoomId(),
      "operatorType": 3,
      "operatorUserId": UserManager.instance.uid,
      "setUserId": info.userId,
      "time": -1,
    };

    ToastUtils.showLoading();
    ChatService.requestAdmainOperat(params, (success, result) {
      if (success) {
        ToastUtils.showSuccess("用户踢出直播间成功");
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  // -------------------------------------------

  Future<ChatMsgModel> prepareSendEnterMsg() async {
    ChatMsgModel msgEnter = ChatMsgModel.empty();
    msgEnter.type = ChatMsgType.enter;
    msgEnter.content = "进入直播间";

    if (UserManager.instance.isLogin()) {
      msgEnter.userId = UserManager.instance.uid;
      msgEnter.nickname = UserManager.instance.user!.nickName;
    } else {
      msgEnter.userId = await UserManager.instance.obtainTouristId();
      msgEnter.nickname = "游客${msgEnter.userId}";
    }

    return msgEnter;
  }

  Future<ChatMsgModel?> chatbarSendMsg(String content, bool forbidChat) async {
    if (!UserManager.instance.isLogin()) {
      ToastUtils.showInfo("登录后才能发言");
      return null;
    }

    if (forbidChat) {
      ToastUtils.showInfo("您已被管理员禁言");
      return null;
    }

    if (content.isEmpty) {
      ToastUtils.showInfo("请输入有趣的内容");
      return null;
    }

    ChatMsgModel msg = ChatMsgModel.empty();
    msg.type = ChatMsgType.common;
    msg.content = content;
    msg.userId = UserManager.instance.uid;
    msg.nickname = UserManager.instance.user!.nickName;

    return verifyMsg(msg);
  }

  Future<ChatMsgModel?> verifyMsg(ChatMsgModel msg) async {
    IMMsgFilterModel? model = await IMService.requestMsgVerify(msg.content);
    if (model == null) {
      ToastUtils.showError("消息发送失败");
      return null;
    }
    if (!model.success) {
      ToastUtils.showError(model.desc);
      return null;
    }

    msg.sign = model.sign;
    msg.pushTime = model.pushTime;

    return msg;

    // sendMsg(msg);
    // barView.clearText();
    // barView.resignFirstResponder();
  }
}
