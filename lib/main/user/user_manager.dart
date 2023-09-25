import 'package:wzty/main/user/user_entity.dart';

class DomainManager {

  factory DomainManager() => _getInstance;

  static DomainManager get instance => _getInstance;

  static final DomainManager _getInstance = DomainManager._internal();
  
  //初始化eventBus
  DomainManager._internal() {
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