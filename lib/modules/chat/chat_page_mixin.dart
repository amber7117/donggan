// import 'package:flutter/material.dart';
import 'package:wzty/main/im/im_msg_filter_entity.dart';
import 'package:wzty/main/im/im_service.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/chat/entity/chat_entity.dart';
import 'package:wzty/utils/toast_utils.dart';

// mixin ChatPageMixin<T extends StatefulWidget> on State<T> {
// }

mixin ChatPageMixin {

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
