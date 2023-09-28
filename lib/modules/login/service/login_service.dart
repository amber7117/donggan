
import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';

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
    var params = {
      "type": type.value,
      "areaNo": "86",
      "phone": phone,
      "disabledGeeTest": 1,
    };
    HttpResultBean result =
        await HttpManager.request(LoginApi.verifyCode, HttpMethod.post, params: params);
    if (result.isSuccess()) {
      complete("");
    } else {
      complete(result.data ?? result.msg);
    }
      
      
  }
}