
import 'package:flutter/material.dart';

class NewsTabProvider extends ChangeNotifier {
  
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
