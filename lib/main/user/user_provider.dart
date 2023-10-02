import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {

  UserProvider(this._isLogin);

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  setIsLogin(bool isLogin) {
    _isLogin = isLogin;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

}
