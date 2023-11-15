import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/dio/http_config.dart';
import 'package:wzty/main/dio/http_result_bean.dart';

import 'package:wzty/main/domain/domain_entity.dart';
import 'package:wzty/main/domain/domain_manager.dart';
import 'package:wzty/main/lib/navigator_provider.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/utils/app_utils.dart';
import 'package:wzty/utils/toast_utils.dart';
import 'package:wzty/utils/wz_date_utils.dart';
import 'package:wzty/utils/wz_string_utils.dart';

enum HttpMethod {
  get(value: "GET"),
  post(value: "POST"),
  upload(value: "UPLOAD");

  const HttpMethod({required this.value});

  final String value;
}

typedef CompleteCallback = void Function(HttpResultBean result);

typedef BusinessCallback<T> = void Function(bool success, T result);

class HttpManager {
  static Dio? dio;
  static bool showLogin = false;

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

    // 空值处理
    params ??= {};

    // post参数处理
    Map<String, dynamic>? data;
    if (method == HttpMethod.post) {
      data = params;
      params = {};
    }

    Map<String, dynamic> headers = await getHeader(params, method);

    headers.addDomainValue(domain);

    try {
      Response response = await instance.request(urlString,
          data: data,
          queryParameters: params,
          options: Options(method: method.value, headers: headers));
      return HttpConfig.handleResponseData(response);
    } on DioException catch (exception) {
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

    headers.addDomainValue(domain);

    try {
      Response response = await instance.request(urlString,
          options: Options(method: HttpMethod.get.value, headers: headers));
      HttpResultBean result = HttpConfig.handleResponseData(response);
      complete(result);
    } on DioException catch (exception) {
      logger.e("----catch--请求错误-----$exception");
      HttpResultBean result = HttpConfig.handleResponseErr();
      complete(result);
    }
  }

  /// 请求cdn domain
  static Future<String?> requestCDNData(String urlString) async {
    Dio instance = getInstance();

    try {
      Response response = await instance.request(
        urlString,
        options: Options(
            method: HttpMethod.get.value, responseType: ResponseType.plain),
      );
      return response.data;
    } on DioException catch (exception) {
      logger.e("----catch--请求错误-----$exception");
      return null;
    }
  }

  /// 创建 dio 实例对象
  static Dio getInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        sendTimeout: const Duration(seconds: 12),
      );

      dio = Dio(options);
      if (appDebug) {
        dio?.interceptors.add(LogInterceptor());
      }
      dio?.interceptors.add(InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        int typeValue = options.headers[domainType] ?? 0;
        if (typeValue > 0) {
          String urlStr = options.uri.toString();

          String signTypeValue = options.headers[domainSignType];
          String tokenValue = options.headers[domainToken];

          if (signTypeValue == "B") {
            urlStr = WZStringUtils.signTypeB(urlStr, tokenValue, typeValue);
          } else {
            urlStr = WZStringUtils.signTypeA(urlStr, tokenValue, typeValue);
          }

          options.path = urlStr;

          if (options.method == HttpMethod.get.value) {
            options.queryParameters = {};
          }

          options.headers.removeDomainValue();
        }
        return handler.next(options);
      }));
      dio?.interceptors.add(InterceptorsWrapper(onResponse:
          (Response<dynamic> e, ResponseInterceptorHandler handler) {
        if (e.data is Map) {
          Map result = e.data;
          int code = result["code"] ?? 0;
          if (code > 380 && code < 520) {
            // ZQDomainManager.shared.removeDomain(domain: domainModel);
          } else if (code >= 9527 && code <= 9530) {
            handleErrorCode(result["msg"], code);
          } else {
            showLogin = false;
          }
          return handler.next(e);
        }
      }));

      // 抓包代码
      if (appProxy) {
        (dio?.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient client) {
          client.idleTimeout = const Duration(seconds: 12);
          client.findProxy = (uri) {
            return appProxyIP;
          };
          // 代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return null;
        };
      }
    }
    return dio!;
  }

  static void handleErrorCode(String msg, int code) {
    if (showLogin) return;
    showLogin = true;

    if (UserManager.instance.isLogin()) {
      UserManager.instance.removeUser();
    }

    // 冻结用户&其他设备登录
    if (9527 == code || 9530 == code) {
      Routes.goLoginPage(NavigatorProvider.navigatorContext!);
      Future.delayed(const Duration(milliseconds: 500), () {
        ToastUtils.showError(msg);
      });
    } else {
      ToastUtils.showError(msg);
      Future.delayed(const Duration(seconds: 2), () {
        exit(1);
      });
    }
  }

  static Future<Map<String, dynamic>> getHeader(
      Map<String, dynamic> params, HttpMethod method) async {
    Map<String, dynamic> headers = {};
    headers["Content-Type"] = "application/json";

    headers["version"] = "1.0.0";
    headers["client-type"] = "ios";

    headers["source"] = "WZTY";
    headers["channel"] = "WZTY";
    headers["channelApp"] = "WZTY";

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
      signValue = WZStringUtils.signGetRequest(params, signMD5, milliseconds);
    } else {
      signValue = WZStringUtils.signPostRequest(params, signMD5, milliseconds);
    }
    headers["sign"] = signValue;

    String randomStr = WZStringUtils.generateRandomString(20);
    headers["r"] = randomStr;

    return headers;
  }
}

extension Domain on Map {
  addDomainValue(DomainEntity domain) {
    this[domainType] = domain.domainType;
    this[domainToken] = domain.token;
    this[domainSignType] = domain.signType;
  }

  removeDomainValue() {
    remove(domainType);
    remove(domainSignType);
    remove(domainToken);
  }
}
