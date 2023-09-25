import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:wzty/app/app.dart';

/// 全局的 EventBus
/// https://www.cnblogs.com/liuys635/p/14670967.html
///
typedef EventCallback<T> = void Function(T event);

class EventBusManager {

  factory EventBusManager() => _getInstance;

  static EventBusManager get instance => _getInstance;

  static final EventBusManager _getInstance = EventBusManager._internal();
  
  //初始化eventBus
  late EventBus _eventBus;
  EventBusManager._internal() {
    logger.i("EventBusManager._internal()");
    _eventBus = EventBus();
  }

  // 开启eventbus订阅
  StreamSubscription on<T>(EventCallback<T> callback) {
    StreamSubscription stream = _eventBus.on<T>().listen((event) {
      callback(event);
    });
    return stream;
  }

  /// 发送消息
  void emit(event) {
    _eventBus.fire(event);
  }

  // 移除steam
  void off(StreamSubscription? steam) {
    steam?.cancel();
  }

  //event销毁，为了防止内存泄漏，一般在应用销毁时都需要对 EventBus 进行销毁：
  void onDestroy() {
    _eventBus.destroy();
  }
}

EventBusManager eventBusManager = EventBusManager.instance;
