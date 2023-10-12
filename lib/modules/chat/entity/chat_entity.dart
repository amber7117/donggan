import 'dart:convert';

import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

class ChatMsgModel {
  int wealthLevel;
  int nobleLevel;
  String userId;
  String nickname;
  String headUrl;
  int identity;
  String content;
  bool isLink;
  String sign;
  int sendTime;
  int pushTime;
  String messageUId;

  ChatMsgType type;

  late String nameNew;
  late String contentNew;
  late double msgHeight;

  ChatMsgModel({
    required this.wealthLevel,
    required this.nobleLevel,
    required this.userId,
    required this.nickname,
    required this.headUrl,
    required this.identity,
    required this.content,
    required this.isLink,
    required this.sign,
    required this.sendTime,
    required this.pushTime,
    required this.type,
    required this.messageUId,
  }) {
    nameNew =
        nickname.contains('斗球') ? nickname.replaceAll('斗球', '') : nickname;
    contentNew = content.trim();
    msgHeight = 0.0;
  }

  factory ChatMsgModel.empty() => ChatMsgModel(
        wealthLevel: 0,
        nobleLevel: 0,
        userId: '',
        nickname: '',
        headUrl: '',
        identity: 0,
        content: '',
        isLink: false,
        sign: '',
        sendTime: 0,
        pushTime: 0,
        type: ChatMsgType.enter,
        messageUId: '',
      );

  factory ChatMsgModel.fromJson(Map<String, dynamic> json) => ChatMsgModel(
        wealthLevel: json['wealthLevel'] ?? 0,
        nobleLevel: json['nobleLevel'] ?? 0,
        userId: json['userId'] ?? '',
        nickname: json['nickname'] ?? '',
        headUrl: json['headUrl'] ?? '',
        identity: json['identity'] ?? 0,
        content: json['content'] ?? '',
        isLink: json['isLink'] ?? false,
        sign: json['sign'] ?? '',
        sendTime: json['sendTime'] ?? 0,
        pushTime: json['pushTime'] ?? 0,
        type: ChatMsgTypeEnum.fromInt(json['type'] ?? 1),
        messageUId: json['messageUId'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'wealthLevel': wealthLevel,
        'nobleLevel': nobleLevel,
        'userId': userId,
        'nickname': nickname,
        'headUrl': headUrl,
        'identity': identity,
        'content': content,
        'isLink': isLink,
        'sign': sign,
        'sendTime': sendTime,
        'pushTime': pushTime,
        'type': type.toInt(),
        'messageUId': messageUId,
      };

  static ChatMsgModel? getMsgByRcMsg(RCIMIWMessage rcMsg) {
    if (rcMsg is RCIMIWTextMessage) {
      RCIMIWTextMessage tcTextMsg = rcMsg;
      if (tcTextMsg.text != null) {
        final msg = ChatMsgModel.fromJson(json.decode(tcTextMsg.text!));
        msg.messageUId = rcMsg.messageUId ?? '';
        msg.sendTime = rcMsg.sentTime ?? 0;
        return msg;
      }
    }
    return null;
  }

  // BarrageDescriptor getBarrageDescriptor() {
  //   final descriptor = BarrageDescriptor();
  //   descriptor.spriteName = '${BarrageWalkTextSprite}';

  //   descriptor.params['text'] = content;
  //   descriptor.params['textColor'] =
  //       UIColor.RGB(255, 255, 255, ZQConfigManager.shared.barrageOpacity / 100.0)
  //           .toString();
  //   descriptor.params['fontSize'] = ZQConfigManager.shared.barrageFont.toString();
  //   descriptor.params['fontFamily'] = 'PingFangSC-Regular';
  //   descriptor.params['speed'] = (0.5 * content.length + 60.0);
  //   descriptor.params['delay'] = barrageDelay;
  //   descriptor.params['direction'] = 1;

  //   return descriptor;
  // }

  static ChatMsgModel getHintMsg() {
    final msg = ChatMsgModel.empty();
    msg.content = '系统提示：严禁刷屏、言语冲突，违规者封禁账号';
    msg.type = ChatMsgType.local;
    return msg;
  }
}

enum ChatMsgType {
  other,
  local,
  common,
  enter,
  msgRecall,
  kickout,
  forbidChat,
  unforbidChat,
  msgRecallNotify
}

extension ChatMsgTypeEnum on ChatMsgType {
  static ChatMsgType fromInt(int value) {
    switch (value) {
      case -2:
        return ChatMsgType.other;
      case -1:
        return ChatMsgType.local;
      case 0:
        return ChatMsgType.common;
      case 1:
        return ChatMsgType.enter;
      case 101:
        return ChatMsgType.msgRecall;
      case 102:
        return ChatMsgType.kickout;
      case 103:
        return ChatMsgType.forbidChat;
      case 104:
        return ChatMsgType.unforbidChat;
      case 300:
        return ChatMsgType.msgRecallNotify;
      default:
        throw Exception('Invalid value: $value');
    }
  }

  int toInt() {
    switch (this) {
      case ChatMsgType.other:
        return -2;
      case ChatMsgType.local:
        return -1;
      case ChatMsgType.common:
        return 0;
      case ChatMsgType.enter:
        return 1;
      case ChatMsgType.msgRecall:
        return 101;
      case ChatMsgType.kickout:
        return 102;
      case ChatMsgType.forbidChat:
        return 103;
      case ChatMsgType.unforbidChat:
        return 104;
      case ChatMsgType.msgRecallNotify:
        return 300;
    }
  }
}
