import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'package:wzty/utils/date_utils.dart';

const signMD5 = "9e304d4e8df1b74cfa009913198428ab";

class StringUtils {
  static String generateRandomString(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String result = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(charset.length);
      result += charset[randomIndex];
    }

    return result;
  }

  static String signGetRequest(
      dynamic param, String md5Key, String milliseconds) {
    List<String> keyValues = [];

    if (param is Map<String, dynamic>) {
      List<String> allKeyArray = param.keys.toList();
      List<String> afterSortKeyArray = allKeyArray..sort();

      List<String> valueArray = [];
      for (String sortedString in afterSortKeyArray) {
        String valueString = (param[sortedString] as String?) ?? "";
        valueArray.add(valueString);
      }

      for (int idx = 0; idx < afterSortKeyArray.length; idx++) {
        keyValues.add("${afterSortKeyArray[idx]}=${valueArray[idx]}");
      }
    }

    if (md5Key.isNotEmpty) {
      keyValues.add("key=$md5Key");
    }

    if (milliseconds.isNotEmpty) {
      keyValues.add("t=$milliseconds");
    }

    String keyValueStr = keyValues.join('&');

    String md5Str = md5.convert(utf8.encode(keyValueStr)).toString();
    return sha1.convert(utf8.encode(md5Str)).toString();
  }

  static String signPostRequest(
      dynamic param, String md5Key, String milliseconds) {
    String keyValueStr = "";

    if (param is Map<String, dynamic>) {
      keyValueStr = param.toString();
      keyValueStr = "$keyValueStr&key=$md5Key";
    } else {
      keyValueStr = "key=$md5Key";
    }

    keyValueStr = "$keyValueStr&t=$milliseconds";

    String md5Str = md5.convert(utf8.encode(keyValueStr)).toString();
    return sha1.convert(utf8.encode(md5Str)).toString();
  }

  static String signTypeA(String urlS, String token, int typeValue) {
    String urlStr = urlS;
    String keyStr = "";

    if (typeValue == 1) {
      keyStr = "auth_key";
    } else if (typeValue == 2) {
      keyStr = "sign";
    } else if (typeValue == 3) {
      keyStr = "auth_key";
    }

    if (keyStr.isEmpty || urlStr.contains("$keyStr=")) {
      return urlStr;
    }

    //短连接请求
    String uriPath = "";

    if (urlStr.contains(":")) {
      Uri uri = Uri.tryParse(urlStr) ?? Uri();
      if (uri.host.isEmpty) {
        return urlStr;
      }

      String hostUrl = "${uri.scheme}://${uri.host}";
      uriPath = urlStr.substring(hostUrl.length);
    } else {
      uriPath = urlStr;
    }

    String uriPathShort = uriPath;

    if (uriPath.contains("?")) {
      uriPathShort = uriPath.split("?").first;
    }

    // 随机字符串
    String randomStr = generateRandomString(20);
    randomStr = randomStr.toLowerCase();

    // 阿里authkey 随机字符串用0表示，同步安卓
    if (typeValue == 1) {
      randomStr = "0";
    }

    /// 时间戳
    int timeInterval = WZDateUtils.currentTimeMillis() ~/ 1000;

    if (typeValue != 3) {
      timeInterval += 3600; // 一小时后过期
    }

    String uriPathNew = "$uriPathShort-$timeInterval-$randomStr-0-$token";
    String md5Str = md5.convert(utf8.encode(uriPathNew)).toString();

    String urlStrNew = "";

    if (urlStr.contains("?")) {
      urlStrNew = "$urlStr&$keyStr=$timeInterval-$randomStr-0-$md5Str";
    } else {
      urlStrNew = "$urlStr?$keyStr=$timeInterval-$randomStr-0-$md5Str";
    }

    return urlStrNew;
  }

  static String signTypeB(String urlS, String token, int typeValue) {
    String urlStr = processUrl202(urlS);

    // 短连接请求
    String uriPath = "";
    String hostUrl = "";
    if (urlStr.contains(":")) {
      Uri url = Uri.parse(urlStr);

      if (url.host.isEmpty) {
        return urlStr;
      }

      hostUrl = "${url.scheme}://${url.host}";
      uriPath = urlStr.substring(hostUrl.length);
    } else {
      uriPath = urlStr;
    }

    String uriPathShort = uriPath;
    if (uriPath.contains("?")) {
      uriPathShort = uriPath.split("?").first;
    }

    // 时间戳
    DateTime date = DateTime.now().subtract(const Duration(minutes: 10));
    String dateStr = cdnFormatter.format(date);

    String uriPathNew = token + dateStr + uriPathShort;
    String md5Str = md5.convert(utf8.encode(uriPathNew)).toString();

    String urlStrNew = "";
    if (urlStr.contains("?")) {
      urlStrNew = "$hostUrl/$dateStr/$md5Str$uriPath";
    } else {
      urlStrNew = "$dateStr/$md5Str$uriPath";
    }

    return urlStrNew;
  }

  static String processUrl202(String urlStr) {
    String newSr = urlStr;
    List<String> array = urlStr.split("/");

    if (urlStr.contains("/202") && array.length > 4) {
      String lastDateString = array[3];
      String lastMD5String = array[4];
      String temp = "/$lastDateString/$lastMD5String";
      newSr = urlStr.replaceAll(temp, "");
    }

    return newSr;
  }

  static DateFormat cdnFormatter = DateFormat("yyyyMMddHHmm");
}
