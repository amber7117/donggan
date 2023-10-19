import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';

class MatchDataProvider extends ChangeNotifier {
  // MatchDataProvider();

  /// 比赛状态
  MatchStatus matchStatus = MatchStatus.going;

  void refresh() {
    notifyListeners();
  }
}
