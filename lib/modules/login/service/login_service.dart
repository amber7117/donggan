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
  static Future<HttpResultBean> requestVerifyCode(
      String phone, VerifyCodeType type) async {
    Map<String, dynamic> params = {
      "type": type.value,
      "areaNo": "86",
      "phone": phone,
      "disabledGeeTest": 1,
    };

    HttpResultBean result = await HttpManager.request(
        LoginApi.verifyCode, HttpMethod.post,
        params: params);

    return result;
  }

  static Future<void> requestLogin(String phone, String code, bool isPwd,
      BusinessCallback<dynamic> complete) async {
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
      UserManager.instance.saveUser(user);

      complete(true, user);
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  static Future<void> requestSetPwdTicket(
      String phone, String code, BusinessCallback<String> complete) async {
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
    complete(result.isSuccess(), ticket);
  }

  static Future<void> requestSetPwd(String phone, String pwd, String ticketS,
      BusinessCallback<dynamic> complete) async {
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
      UserManager.instance.saveUser(user);

      complete(true, user);
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  static Future<void> requestLoginSetPwd(String phone, String pwd,
      String ticketS, BusinessCallback<dynamic> complete) async {
    Map<String, dynamic> params = {
      "userName": phone,
      "passWord": pwd,
      "ticket": ticketS,
    };

    HttpResultBean result = await HttpManager.request(
        LoginApi.loginSetPwd, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      complete(true, "");
    } else {
      complete(false, result.msg ?? result.data);
    }
  }

  static Future<void> requestLogout(BusinessCallback<String> complete) async {
    Map<String, dynamic> params = {"userId": UserManager.instance.uid};

    HttpResultBean result = await HttpManager.request(
        LoginApi.logout, HttpMethod.get,
        params: params);

    String msg = "";
    if (!result.isSuccess()) {
      msg = result.msg ?? result.data;
    }
    complete(result.isSuccess(), msg);
  }
}
