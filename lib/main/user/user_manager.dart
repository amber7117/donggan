import 'package:wzty/main/user/user_entity.dart';

class USerManager {

  factory USerManager() => _getInstance;

  static USerManager get instance => _getInstance;

  static final USerManager _getInstance = USerManager._internal();
  
  //初始化eventBus
  USerManager._internal() {
  }

  isLogin() {
    if (token.isNotEmpty && uid > 0) {
      return true;
    }
    return false;
  }



  // UserEntity? user;

  String token = "";

  int uid = 0;

  String headImg = "";

  String nickName = "";

  String personalDesc = "";

  String mobile = "";

}