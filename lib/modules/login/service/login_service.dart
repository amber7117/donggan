
import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_entity.dart';
import 'package:wzty/main/user/user_manager.dart';

enum VerifyCodeType {
  login(value: 1),
  forgetPwd(value: 2),
  modifyInfo(value: 3),
  deleteAccount(value: 6);

  const VerifyCodeType({required this.value});

  final int value;
}

class LoginService {

  static Future<void> requestVerifyCode(String phone, VerifyCodeType type, BusinessSuccess<String> complete) async {
    Map<String, dynamic> params = {
      "type": type.value,
      "areaNo": "86",
      "phone": phone,
      "disabledGeeTest": 1,
    };

    HttpResultBean result = await HttpManager.request(
        LoginApi.verifyCode, HttpMethod.post,
        params: params);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    } 
    complete(msg);
  }

  static Future<void> requestLogin(String phone, String code, bool isPwd,
      BusinessSuccess<String> complete) async {
    Map<String, dynamic> params = {};
    if (isPwd) {
      params = {
        "userName": phone,
        "areaNo": "86",
        "passWord": code,
        "type": "iOS",
      };
    } else {
      params = {
        "userName": phone,
        "areaNo": "86",
        "code": code,
        "type": "iOS",
        "inviteCode": "",
      };
    }

    HttpResultBean result = await HttpManager.request(
        LoginApi.login, HttpMethod.post,
        params: params);

    if (result.isSuccess()) {
      UserEntity user = UserEntity.fromJson(result.data);
      UserManager.instance.saveUserInfo(user);

      complete("");
    } else {
      complete(result.data ?? result.msg);
    }
  }

  static Future<void> requestSetPwdTicket(String phone, String code,
      BusinessSuccess<String> complete) async {
    Map<String, dynamic> params = {
      "type": "iOS",
      "areaNo": "86",
      "userName": phone,
      "code": code,
    };

    HttpResultBean result = await HttpManager.request(
        LoginApi.setPwdTicket, HttpMethod.get,
        params: params);

    String ticket = "";

    if (result.isSuccess()) {
      ticket = result.data["ticket"];
    }
    complete(ticket);
  }

  static Future<void> requestSetPwd(String phone, String pwd, String ticketS,
      BusinessSuccess<String> complete) async {
    Map<String, dynamic> params = {
      "userName": phone,
      "areaNo": "86",
      "passWord": pwd,
      "ticket": ticketS,
    };

    HttpResultBean result = await HttpManager.request(
        LoginApi.setPwd, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      UserEntity user = UserEntity.fromJson(result.data);
      UserManager.instance.saveUserInfo(user);

      complete("");
    } else {
      complete(result.data ?? result.msg);
    }
  }

  static Future<void> requestLogout(BusinessSuccess<String> complete) async {
    Map<String, dynamic> params = {"userId": UserManager.instance.uid};

    HttpResultBean result = await HttpManager.request(
        LoginApi.logout, HttpMethod.get,
        params: params);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.data ?? result.msg;
    }
    complete(msg);
  }
  

}