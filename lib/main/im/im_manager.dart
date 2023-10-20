import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/im/im_service.dart';

class IMManager {
  factory IMManager() => _getInstance;

  static IMManager get instance => _getInstance;

  static final IMManager _getInstance = IMManager._internal();

  IMManager._internal();

  // ---------------------------------------------

  bool connectOK = false;
  String appkey = "ik1qhw09ignwp";
  String roomId = "";

  late RCIMIWEngine _engine;
  RCIMIWEngine get engine => _engine;
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
    _engine = await RCIMIWEngine.create(appkey, options);
    inited = true;

    connectIM();
  }

  void connectIM({WZVoidCallback? callback}) async {
    String? result = await IMService.requestToken();
    if (result == null) {
      connectOK = false;
      return;
    }

    _engine.connect(result, 0,
        callback: RCIMIWConnectCallback(onDatabaseOpened: (code) {
          if (code != 0) {
            connectOK = false;
            logger.e("dbOpened failure $code");
          }
        }, onConnected: (code, userId) {
          if (code != 0 && code != 34001) {
            connectOK = false;
            logger.e("connect failure $code");
          } else {
            connectOK = true;
            if (callback != null) {
              callback();
            }
          }
        }));
  }

  void disconnectIM() {
    _engine.disconnect(false);
  }

  void sendMsgToIMRoom(String roomId, String msgJSONStr,
      WZListCallback<int?, RCIMIWMessage?> callback) async {
    RCIMIWTextMessage? textMessage = await _engine.createTextMessage(
      RCIMIWConversationType.chatroom,
      roomId,
      null,
      msgJSONStr,
    );
    if (textMessage == null) {
      logger.e("textMessage error");
    }
    _engine.sendMessage(textMessage!,
        callback: RCIMIWSendMessageCallback(onMessageSent: (code, message) {
      callback(code, message);
    }));
  }

  void addIMConnectionStatusChangeDelegate(
      WZListCallback<int?, RCIMIWMessage?> callback) {
    _engine.onConnectionStatusChanged = (status) {};
  }

  void addIMChatRoomStatusDelegate(
      WZListCallback<int?, RCIMIWMessage?> callback) {
    _engine.onChatRoomStatusChanged = (targetId, status) {};
  }

  void addIMReceiveMessageDelegate(
      WZListCallback<int?, RCIMIWMessage?> callback) {
    _engine.onMessageReceived = (message, left, offline, hasPackage) {};
  }
}
