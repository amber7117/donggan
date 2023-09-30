import 'package:flutter/material.dart';

class LoginDataProvider extends ChangeNotifier {
  
  String phone = "";

  String verifyCode = "";

  String pwd = "";

  bool isPwdLogin = false;

  checkLoginStatue() {
    if (isPwdLogin) {
      if (phone.length == 11 && pwd.length > 5) {
        setCanLogin(true);
      } else {
        setCanLogin(false);
      }
    } else {
      if (phone.length == 11 && pwd.length == 6) {
        setCanLogin(true);
      } else {
        setCanLogin(false);
      }
    }
  }

  bool _canLogin = false;
  bool get canLogin => _canLogin;
  void setCanLogin(bool value) {
    _canLogin = value;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

}
