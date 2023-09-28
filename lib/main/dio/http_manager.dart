
import 'package:dio/dio.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_config.dart';
import 'package:wzty/main/dio/http_result_bean.dart';

import 'package:wzty/main/domain/domain_entity.dart';
import 'package:wzty/main/domain/domain_manager.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/utils/app_utils.dart';
import 'package:wzty/utils/date_utils.dart';
import 'package:wzty/utils/string_utils.dart';

enum HttpMethod {
  get(value: "get"),
  post(value: "post"),
  upload(value: "upload");

  const HttpMethod({required this.value});

  final String value;
}

typedef CompleteCallback = void Function(HttpResultBean result);
typedef BusinessSuccess<T> = void Function(T result);

class HttpManager {
  static Dio? dio;

  /// 业务请求
  static Future<HttpResultBean> request(
    String path,
    HttpMethod method, {
    Map<String, dynamic>? params,
  }) async {
    DomainEntity? domain = DomainManager.instance.currentDomain();
    if (domain == null) {
      return HttpConfig.handleDomianErr();
    }

    String urlString;
    if (path.startsWith("/")) {
      urlString = '${domain.domain}$path';
    } else {
      urlString = '${domain.domain}/$path';
    }

    Dio instance = getInstance();

    params ??= {};

    Map<String, dynamic> headers = await getHeader(params, method);

    headers[domainType] = domain.domainType;
    headers[domainToken] = domain.token;
    headers[domainSignType] = domain.signType;

    try {
      Response response = await instance.request(urlString,
          options: Options(method: method.value, headers: headers));
      // logger.i(response.data);
      return HttpConfig.handleResponseData(response);
    } catch (exception) {
      logger.e("----catch--请求错误-----$exception");
      return HttpConfig.handleResponseErr();
    }
  }

  /// 请求ping
  static Future<void> pingWithCB(
      DomainEntity domain, CompleteCallback complete) async {
    String urlString = '${domain.domain}/ping';

    Dio instance = getInstance();

    Map<String, dynamic> headers = {};

    headers[domainType] = domain.domainType;
    headers[domainToken] = domain.token;
    headers[domainSignType] = domain.signType;

    try {
      Response response = await instance.request(urlString,
          options: Options(method: HttpMethod.get.value, headers: headers));
      HttpResultBean result = HttpConfig.handleResponseData(response);
      complete(result);
    } catch (exception) {
      logger.e("----catch--请求错误-----$exception");
      HttpResultBean result = HttpConfig.handleResponseErr();
      complete(result);
    }
  }

  /// 请求cdn domain
  static Future<HttpResultBean> requestCDNData(String urlString) async {
    Dio instance = getInstance();

    try {
      Response response = await instance.request(urlString);
      return HttpConfig.handleResponseData(response);
    } catch (exception) {
      logger.e("----catch--请求错误-----$exception");
      return HttpConfig.handleResponseErr();
    }
  }

  /// 创建 dio 实例对象
  static Dio getInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      );

      dio = Dio(options);
      dio?.interceptors.add(LogInterceptor());
      dio?.interceptors.add(InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async { 

        int typeValue = options.headers[domainType] ?? 0;
        if (typeValue > 0) {
          String urlStr = options.uri.toString();

          String signTypeValue = options.headers[domainSignType];
          String tokenValue = options.headers[domainToken];

          if (signTypeValue == "B") {
            urlStr = StringUtils.signTypeB(urlStr, tokenValue, typeValue);
          } else {
            urlStr = StringUtils.signTypeA(urlStr, tokenValue, typeValue);
          }
          
          options.path = urlStr;

          if (options.method == HttpMethod.get.value) {
            options.queryParameters = {};
          }

          options.headers[domainSignType] = "";
          options.headers[domainToken] = "";
        }
        return handler.next(options);
      }));
    }
    return dio!;
  }

  static Future<Map<String, dynamic>> getHeader(
      Map<String, dynamic> params, HttpMethod method) async {
    Map<String, dynamic> headers = {};
    headers["Content-Type"] = "application/json";

    headers["version"] = "1.0.0";
    headers["client-type"] = "ios";

    headers["source"] = "ZQTY";
    headers["channel"] = "ZQTY";
    headers["channelApp"] = "ZQTY";

    if (UserManager.instance.isLogin()) {
      headers["Authorization"] = "Bearer ${UserManager.instance.token}";
      headers["x-user-header"] = "{\"uid\":${UserManager.instance.uid}}";
    } else {
      headers["Authorization"] = "Basic YXBwOmFwcA==";
      headers["x-user-header"] = "{\"uid\":0}";
    }

    String deveiceID = await AppUtils.getPlatformUid();
    headers["deviceId"] = deveiceID;

    String milliseconds = "${WZDateUtils.currentTimeMillis()}";
    headers["t"] = milliseconds;

    String signValue = "";
    if (method == HttpMethod.get) {
      signValue = StringUtils.signGetRequest(params, signMD5, milliseconds);
    } else {
      signValue = StringUtils.signPostRequest(params, signMD5, milliseconds);
    }
    headers["sign"] = signValue;

    String randomStr = StringUtils.generateRandomString(20);
    headers["r"] = randomStr;

    return headers;
  }
}
