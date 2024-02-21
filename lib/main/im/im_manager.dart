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

    IMService.requestInitInfo((success, result) {
      if (success) {
        inited = true;
        
        if (result.isNotEmpty) {
          appkey = result;
        }
        
        _initSDK();
      } else {
        // 如果不成功 延迟2s继续请求
        Future.delayed(const Duration(seconds: 2), () {
          prepareInitSDK();
        });
      }
    });
  }

  void _initSDK() async {
    RCIMIWEngineOptions options = RCIMIWEngineOptions.create();
    _engine = await RCIMIWEngine.create(appkey, options);

    prepareConnectIM();
  }

  void prepareConnectIM({WZVoidCallback? callback}) async {
    IMService.requestToken((success, result) {
      if (success) {
        _connectIM(result, callback: callback);
      } else {
        connectOK = false;

        // 如果不成功 延迟2s继续请求
        Future.delayed(const Duration(seconds: 2), () {
          prepareConnectIM();
        });
      }
    });
  }

  void _connectIM(token, {WZVoidCallback? callback}) async {
    _engine.connect(token, 0,
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
}
