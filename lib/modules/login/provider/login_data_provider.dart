import 'package:flutter/material.dart';

class NewsTabProvider extends ChangeNotifier {
  
  bool isPwdLogin = false;


  int _index = 0;
  int get index => _index;

  void refresh() {
    notifyListeners();
  }

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
