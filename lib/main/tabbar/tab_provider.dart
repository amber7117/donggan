import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  /// Tab的下标
  int _index = 0;
  int get index => _index;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}

class TabDotProvider extends ChangeNotifier {
  TabDotProvider(this._dotNum);

  /// Tab的下标
  int _index = 0;
  int get index => _index;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  /// 红点数值
  int _dotNum = 0;
  int get dotNum => _dotNum;

  void setDotNum(int num) {
    _dotNum = num;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
