
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

class HttpManager {
  static Dio? dio;

  static requestWithCallback(
    String path,
    HttpMethod method, {
    params,
    Function? onSuccess,
    Function? onFail,
  }) async {

    DomainEntity? domain = DomainManager.instance.currentDomain();
    if (domain == null) {
      return;
    }

    String urlString;
    if (path.startsWith("/")) {
      urlString = '${domain.domain}$path';
    } else {
      urlString = '${domain.domain}/$path';
    }

    Dio instance = getInstance();

    Map<String, dynamic> headers = await getHeader(params, method);
    try {
      Response response =
          await instance.request(urlString, options: Options(method: method.value, headers: headers));
      debugPrint('response: ${json.encode(response.data)}');
      return response.data;
    } on DioException catch (e) {
      debugPrint('request error:${e.toString()} ${e.response?.data}');
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
