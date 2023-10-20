import 'package:wzty/main/user/user_entity.dart';
import 'package:wzty/utils/app_utils.dart';
import 'package:wzty/utils/shared_preference_utils.dart';

class UserManager {

  factory UserManager() => _getInstance;

  static UserManager get instance => _getInstance;

  static final UserManager _getInstance = UserManager._internal();
  
  UserManager._internal();

  // ---------------------------------------------

  createUser() async {
    Map<String, dynamic>? jsonMap = await SpUtils.getJSON(SpKeys.user);
    if (jsonMap != null) {
       user = UserEntity.fromJson(jsonMap);
    }
    token = await SpUtils.getString(SpKeys.token);
    uid = await SpUtils.getString(SpKeys.uid);
  }

  isLogin() {
    if (token.isNotEmpty && uid.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<String> obtainUseridOrDeviceid() async {
    if (uid.isNotEmpty) {
      return uid.toString();
    } else {
      return await AppUtils.getPlatformUid();
    }
  }

  Future<String> obtainTouristId() async {
    String touristId = await SpUtils.getString(SpKeys.touristId);
    if (touristId.isNotEmpty) {
      return touristId;
    }

    touristId = AppUtils.generateTouristId();
    await SpUtils.save(SpKeys.touristId, touristId);
    return touristId;
  }

  static bool isSelf(String uid) {
    if (uid.isEmpty) {
      return false;
    }
    return UserManager.instance.uid == uid;
  }

  updateUserHeadImg(String headImg) {
    user!.headImg = headImg;
    SpUtils.setJSON(SpKeys.user, user!.toJson());
  }

  updateUserNickName(String nickName) {
    user!.nickName = nickName;
    SpUtils.setJSON(SpKeys.user, user!.toJson());
  }

  updateUserMobile(String mobile) {
    user!.mobile = mobile;
    SpUtils.setJSON(SpKeys.user, user!.toJson());
  }

  updateUserPersonalDesc(String personalDesc) {
    user!.personalDesc = personalDesc;
    SpUtils.setJSON(SpKeys.user, user!.toJson());
  }

  saveUser(UserEntity model) {
    user = model;
    SpUtils.setJSON(SpKeys.user, model.toJson());

    token = model.token;
    uid = model.uid;
  
    SpUtils.save(SpKeys.token, token);
    SpUtils.save(SpKeys.uid, uid);
  }

  removeUser() {
    user = null;
    SpUtils.remove(SpKeys.user);

    token = "";
    uid = "";

    SpUtils.remove(SpKeys.token);
    SpUtils.remove(SpKeys.uid);
  }

  UserEntity? user;

  String token = "";

  String uid = "";

}