import 'package:wzty/main/user/user_entity.dart';
import 'package:wzty/utils/app_utils.dart';
import 'package:wzty/utils/shared_preference_utils.dart';

class UserManager {

  factory UserManager() => _getInstance;

  static UserManager get instance => _getInstance;

  static final UserManager _getInstance = UserManager._internal();
  
  //初始化eventBus
  UserManager._internal() {
    createUser();
  }

  createUser() async {
    token = await SpUtils.getString(SpKeys.token);
    uid = await SpUtils.getString(SpKeys.uid);
    headImg = await SpUtils.getString(SpKeys.headImg);
    nickName = await SpUtils.getString(SpKeys.nickName);
    mobile = await SpUtils.getString(SpKeys.mobile);

    personalDesc = await SpUtils.getString(SpKeys.personalDesc);
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

  static bool isSelf(int uid) {
    if (uid == 0) {
      return false;
    }
    return UserManager.instance.uid == uid;
  }

  updateUserMobile(String mobile) {
    this.mobile = mobile;
    SpUtils.save(SpKeys.mobile, mobile);
  }

  updateUserNickName(String nickName) {
    this.nickName = nickName;
    SpUtils.save(SpKeys.nickName, nickName);
  }

  updateUserHeadImg(String headImg) {
    this.headImg = headImg;
    SpUtils.save(SpKeys.headImg, headImg);
  }

  updateUserPersonalDesc(String personalDesc) {
    this.personalDesc = personalDesc;
    SpUtils.save(SpKeys.personalDesc, personalDesc);
  }

  saveUserInfo(UserEntity model) {
    token = model.token;
    uid = model.uid;
    headImg = model.headImg;
    nickName = model.nickName;
    mobile = model.mobile;
    SpUtils.save(SpKeys.token, token);
    SpUtils.save(SpKeys.uid, uid);
    SpUtils.save(SpKeys.headImg, headImg);
    SpUtils.save(SpKeys.nickName, nickName);
    SpUtils.save(SpKeys.mobile, mobile);
  }

  removeUserInfo(UserEntity model) {
    token = "";
    uid = "";
    headImg = "";
    nickName = "";
    mobile = "";
    SpUtils.remove(SpKeys.token);
    SpUtils.remove(SpKeys.uid);
    SpUtils.remove(SpKeys.headImg);
    SpUtils.remove(SpKeys.nickName);
    SpUtils.remove(SpKeys.mobile);
  }
    
  

  // UserEntity? user;

  String token = "";

  String uid = "";

  String headImg = "";

  String nickName = "";

  String personalDesc = "";

  String mobile = "";

}