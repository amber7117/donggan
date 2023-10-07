import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:wzty/utils/shared_preference_utils.dart';

class AppUtils {

  /// 获取游客id
  static String generateTouristId() {
    List<String> numArr = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    StringBuffer sb = StringBuffer();
    Random random = Random();
    for (int i = 0; i < 5; i++) {
      int idx = random.nextInt(numArr.length);
      sb.write(numArr[idx]);
    }
    return sb.toString();
  }

  /// 获取设备信息
  static Future<dynamic> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    BaseDeviceInfo? dataInfo;
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      dataInfo = iosInfo;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      dataInfo = androidInfo;
    } 
    return dataInfo;
  }

  /// 获取设备的唯一标识 uuid
  static Future<String> getPlatformUid() async {
    String uuid = await SpUtils.getString(SpKeys.uuid);
    if (uuid.isNotEmpty) {
      return uuid;
    }

    var data = await getDeviceInfo();
    if (data == null) {
      return "";
    }
    
    String res = "";
    if (Platform.isIOS) {
      res = data.identifierForVendor;
    } else if (Platform.isAndroid) {
      res = data!.androidId;
    }

    if (res.isNotEmpty) {
      await SpUtils.save(SpKeys.uuid, res);
    }

    return res;
  }
}
