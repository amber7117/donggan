
import 'package:wzty/app/app.dart';

/// 域名状态通知
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