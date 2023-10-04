import 'package:flutter/material.dart';
import 'package:wzty/main/user/user_entity.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(this._user);

  UserEntity? _user;
  UserEntity? get user => _user;

  updateUserInfo(UserEntity? user) {
    _user = user;
    notifyListeners();
  }

  updateUserInfoPart({
    String? headImg,
    String? nickName,
    String? mobile,
    String? pwd,
    String? personalDesc,
  }) {
    if (headImg != null) {
      _user!.headImg = headImg;
    }
    if (nickName != null) {
      _user!.nickName = nickName;
    }
    if (mobile != null) {
      _user!.mobile = mobile;
    }
    if (pwd != null) {}
    if (personalDesc != null) {
      _user!.personalDesc = personalDesc;
    }
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
