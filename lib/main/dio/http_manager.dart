
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wzty/main/domain/domain_entity.dart';
import 'package:wzty/main/domain/domain_manager.dart';

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

    try {
      Response response =
          await instance.request(urlString, options: Options(method: method.value));
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

  static Map<String, dynamic> getHeader() {
    Map<String, dynamic> headers = {};
    headers["Content-Type"] = "application/json";

    headers["version"] = "1.0.0";
    headers["client-type"] = "ios";

    headers["source"] = "ZQTY";
    headers["channel"] = "ZQTY";
    headers["channelApp"] = "ZQTY";


    
    return headers;
  }

}
