import 'package:flutter/material.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/main/im/im_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/chat/entity/chat_entity.dart';
import 'package:wzty/modules/chat/widget/chat_cell_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class ChatPage extends StatefulWidget {
  final String roomId;
  final String chatRoomId;
  final bool isMatch;

  const ChatPage({
    super.key,
    required this.roomId,
    required this.chatRoomId,
    this.isMatch = false,
  });

  @override
  State createState() => _ChatPageState();
}

class _ChatPageState extends KeepAliveWidgetState<ChatPage> {
  int _msgStartTime = 0;
  int _msgCnt = 0;

  bool _alreadyJoinRoom = false;

  List<ChatMsgModel> _msgList = [];

  // ChatUserInfo? chatInfoSelf = 0;
  bool _forbidChat = false;

  @override
  void initState() {
    super.initState();

    _prepareJoinIMRoom();
  }

  @override
  void dispose() {
    super.dispose();

    _leaveIMRoom();
  }

  _prepareJoinIMRoom() {
    IMManager.instance.engine.onConnectionStatusChanged = (status) {
      if (status == RCIMIWConnectionStatus.timeout) {
        ToastUtils.showInfo("聊天室连接超时，聊天请重新进入直播间");
      } else if (status == RCIMIWConnectionStatus.connUserBlocked) {
        ToastUtils.showInfo("您已被踢出当前直播间");
      }
    };

    IMManager.instance.engine.onMessageReceived =
        (message, left, offline, hasPackage) {
      if (message != null) {
        _receiveMsg(message);
      }
    };

    _msgStartTime = DateTime.now().millisecondsSinceEpoch;

    if (IMManager.instance.connectOK) {
      _joinIMRoom();
    } else {
      IMManager.instance.connectIM(callback: () {
        _joinIMRoom();
      });
    }
  }

  _joinIMRoom() {
    _msgStartTime = DateTime.now().millisecondsSinceEpoch;

    IMManager.instance.engine.joinChatRoom(widget.chatRoomId, 50, false,
        callback:
            IRCIMIWJoinChatRoomCallback(onChatRoomJoined: (code, targetId) {
      if (code != 0) {
        _joinIMRoomFail(code!);
      } else {
        _sendEnterMsg();
      }
    }));
  }

  _joinIMRoomFail(int errorCode) {
    logger.e('onChatRoomJoinFailed === ${widget.chatRoomId} === $errorCode');

    if (errorCode == 23409) {
      ToastUtils.showInfo('你已经被踢出当前直播间');
      Routes.goBack(context);
    } else if (errorCode == 22408) {
      ToastUtils.showInfo('您在当前直播间已被禁言');
    } else if (errorCode == 23410) {
      ToastUtils.showInfo('聊天室不存在');
    } else if (errorCode == 23411) {
      ToastUtils.showInfo('加入聊天室失败, 群人员已满');
    } else {
      ToastUtils.showInfo('加入聊天室失败，请稍后重试');
    }
  }

  _sendEnterMsg() async {
    if (_alreadyJoinRoom) {
      return;
    }
    _alreadyJoinRoom = true;

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

    _sendMsg(msgEnter);
  }

  _leaveIMRoom() {
    IMManager.instance.engine.leaveChatRoom(widget.roomId);
    IMManager.instance.engine.onConnectionStatusChanged = null;
    IMManager.instance.engine.onMessageReceived = null;
  }

  _receiveMsg(RCIMIWMessage message) {
    ChatMsgModel? msg = ChatMsgModel.getMsgByRcMsg(message);

    if (msg == null) {
      return;
    }

    // if (MsgBlockManager.shared.uidArr.contains(msg.userId)) {
    //   return;
    // }

    if (msg.type == ChatMsgType.kickout) {
      //被踢出
      if (UserManager.isSelf(msg.content)) {
        ToastUtils.showInfo('您已被管理员踢出直播间');

        Routes.goBack(context);
      }

      return;
    } else if (msg.type == ChatMsgType.forbidChat) {
      //被禁言
      if (UserManager.isSelf(msg.content)) {
        ToastUtils.showInfo('您已被管理员禁言');

        _forbidChat = true;
      }

      return;
    } else if (msg.type == ChatMsgType.unforbidChat) {
      // 解除禁言
      if (UserManager.isSelf(msg.content)) {
        ToastUtils.showInfo('您已被管理员解除禁言');

        _forbidChat = false;
      }

      return;
    } else if (msg.type == ChatMsgType.msgRecall) {
      //撤回的消息通知
      String messageUId = msg.content;
      List<ChatMsgModel> msgListNew = [];

      for (ChatMsgModel tmpMsg in _msgList) {
        if (tmpMsg.messageUId == messageUId) {
          //do nothing
        } else {
          msgListNew.add(tmpMsg);
        }
      }

      _msgList = msgListNew;
      // self.reloadTableData();
      setState(() {});
      return;
    }

    if (msg.type == ChatMsgType.enter || msg.type == ChatMsgType.common) {
      if (msg.type == ChatMsgType.enter) {
        // 去除重复的入场消息
        List<ChatMsgModel> msgListNew = [];

        for (ChatMsgModel tmpMsg in _msgList) {
          if (tmpMsg.type == ChatMsgType.enter && tmpMsg.userId == msg.userId) {
            //do nothing
          } else {
            msgListNew.add(tmpMsg);
          }
        }

        msgListNew.add(msg);
        _msgList = msgListNew;

        // self.reloadTableDataAndScroll(animated: false);
        setState(() {});
      } else {
        _msgList.add(msg);
        setState(() {});
        // self.reloadTableDataAndScroll(animated: true);

        // self.receiveBarrage(msg: msg);
      }
    }
  }

  _sendMsg(ChatMsgModel msg) {
    String msgStr = msg.getMsgJsonStr();
    if (msgStr.isEmpty) {
      ToastUtils.showInfo("消息异常");
      return;
    }

    IMManager.instance.sendMsgToIMRoom(widget.chatRoomId, msgStr, (data1, data2) {
      if (data2 != null) {
        ChatMsgModel? msgTmp = ChatMsgModel.getMsgByRcMsg(data2);
        if (msgTmp == null) {
          return;
        }
        
        _msgList.add(msgTmp);

        if (msgTmp.type == ChatMsgType.enter) {
          ChatMsgModel hintMsg = ChatMsgModel.getHintMsg();
          _msgList.add(hintMsg);
        }

        setState(() {});
        // self?.receiveBarrage(msg: msg)
      } else {
        _joinIMRoomFail(data1 ?? 0);
      }
    });
  }

  
  @override
  Widget buildWidget(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 3),
        itemCount: _msgList.length,
        itemBuilder: (context, index) {
          return ChatCellWidget(model: _msgList[index]);
        }).colored(Colors.white);
  }
}
