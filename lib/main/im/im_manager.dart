import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/im/im_service.dart';

class IMManager {
  factory IMManager() => _getInstance;

  static IMManager get instance => _getInstance;

  static final IMManager _getInstance = IMManager._internal();

  IMManager._internal();

  //---------------------------------------------

  bool connectOK = false;
  String appkey = "ik1qhw09ignwp";
  String roomId = "";

  late RCIMIWEngine engine;
  bool inited = false;

  void prepareInitSDK() async {
    if (inited) {
      return;
    }

    String? result = await IMService.requestInitInfo();
    if (result != null) {
      appkey = result;
    }
    RCIMIWEngineOptions options = RCIMIWEngineOptions.create();
    engine = await RCIMIWEngine.create(appkey, options);
    inited = true;

    connectIM();
  }

  void connectIM() async {
    String? result = await IMService.requestToken();
    if (result == null) {
      connectOK = false;
      return;
    }

    engine.connect(result, 0,
        callback: RCIMIWConnectCallback(onDatabaseOpened: (code) {
          if (code != 0) {
            connectOK = false;
            logger.e("dbOpened failure $code");
          }
        }, onConnected: (code, userId) {
          if (code != 0) {
            connectOK = false;
            logger.e("connect failure $code");
          } else {
            connectOK = true;
          }
        }));
  }

  void disconnectIM() {
    engine.disconnect(false);
  }

  void enterIMRoom(String roomId, int msgCnt) {
    this.roomId = roomId;
    engine.joinChatRoom(roomId, msgCnt, false, callback:
        IRCIMIWJoinChatRoomCallback(onChatRoomJoined: (code, targetId) {
      if (code != 0) {
        logger.e("joinChatRoom $roomId error $code");
      } else {
        logger.d("joinChatRoom success $roomId");
      }
    }));
  }

  void leaveIMRoom(String roomId, WZAnyCallback<bool> callback) {
    this.roomId = "";
    engine.leaveChatRoom(roomId, callback:
        IRCIMIWLeaveChatRoomCallback(onChatRoomLeft: (code, targetId) {
      if (code != 0) {
        logger.e("quitChatRoom error $roomId code $code");
        callback(false);
      } else {
        logger.d("quitChatRoom success $roomId");
        callback(true);
      }
    }));
  }

  void sendMsgToIMRoom(String roomId, String msgJSONStr,
      WZListCallback<int?, RCIMIWMessage?> callback) async {
    RCIMIWTextMessage? textMessage = await engine.createTextMessage(
      RCIMIWConversationType.chatroom,
      roomId,
      null,
      msgJSONStr,
    );
    if (textMessage == null) {
      logger.e("textMessage error");
    }
    engine.sendMessage(textMessage!,
        callback: RCIMIWSendMessageCallback(onMessageSent: (code, message) {
      callback(code, message);
    }));
  }

  void addIMConnectionStatusChangeDelegate(
      WZListCallback<int?, RCIMIWMessage?> callback) {
    engine.onConnectionStatusChanged = (status) {};
  }

  void addIMChatRoomStatusDelegate(
      WZListCallback<int?, RCIMIWMessage?> callback) {
    engine.onChatRoomStatusChanged = (targetId, status) {};
  }

  void addIMReceiveMessageDelegate(
      WZListCallback<int?, RCIMIWMessage?> callback) {
    engine.onMessageReceived = (message, left, offline, hasPackage) {};
  }
}
