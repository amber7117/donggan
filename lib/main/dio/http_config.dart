
import 'package:dio/dio.dart';
import 'package:wzty/main/dio/http_result_bean.dart';

class HttpConfig {

  static HttpResultBean handleResponseData(Response response) {
    HttpResultBean resultBean;
    try {
      final responseResult = response.data;
      resultBean = HttpResultBean.fromJson(responseResult);
    } catch (exception) {
      resultBean = HttpResultBean(code: response.statusCode, msg: "网络请求异常");
    }
    return resultBean;
  }

  static HttpResultBean handleResponseErr() {
    return HttpResultBean(code: 404, msg: "网络超时");
  }

  static HttpResultBean handleDomianErr() {
    return HttpResultBean(code: 500, msg: "域名异常");
  }

}