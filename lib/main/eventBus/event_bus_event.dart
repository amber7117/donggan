
import 'package:wzty/app/app.dart';

/// 域名状态
class DomainStateEvent {
  final bool ok;

  DomainStateEvent({required this.ok});
}

/// 收藏数据
class MatchCollectDataEvent {

  final SportType sportType;

  final int value;

  MatchCollectDataEvent({required this.sportType, required this.value});
}

/// 登录状态
class LoginStatusEvent {

  final bool login;

  LoginStatusEvent({required this.login});
}
