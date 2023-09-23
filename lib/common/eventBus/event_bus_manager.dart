import 'dart:async';

import 'package:event_bus/event_bus.dart';

/// 全局的 EventBus
/// https://www.cnblogs.com/liuys635/p/14670967.html
/// 
typedef EventCallback<T> = void Function(T event);

class EventBusManager {
  
  static final EventBusManager _instance = EventBusManager._internal();

  static EventBusManager get instance => _instance;

  factory EventBusManager() => _instance;

  //初始化eventBus
  late EventBus _eventBus;

  EventBusManager._internal() {
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

var eventBusManager = EventBusManager.instance;
