
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpManager {
  static Dio dio = Dio();

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';

  static requestWithCallback(
    String url,
    String method, {
    params,
    Function? onSuccess,
    Function? onFail,
  }) async {
    try {
      Response response =
          await dio.request(url, options: Options(method: method));
      debugPrint('response: ${json.encode(response.data)}');
      return response.data;
    } on DioException catch (e) {
      debugPrint('request error:${e.toString()} ${e.response?.data}');
    }
  }
}
