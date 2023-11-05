import 'package:intl/intl.dart';

class WZDateUtils {
  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String getWeekDay(DateTime date) {
    switch (date.weekday) {
      case 1:
        return '星期一';
      case 2:
        return '星期二';
      case 3:
        return '星期三';
      case 4:
        return '星期四';
      case 5:
        return '星期五';
      case 6:
        return '星期六';
      case 7:
        return '星期日';
      default:
        return '';
    }
  }

  /// 时间戳转成事件字符串
  static String getDateDesc(String timeStr) {
    DateTime timeDate = DateTime.parse(timeStr);

    Duration timeInterval = DateTime.now().difference(timeDate);

    int tmp = timeInterval.inSeconds;
    String desc = "";
    while (true) {
      if (timeInterval.inSeconds < 60) {
        desc = "刚刚";
        break;
      }

      tmp = tmp ~/ 60;
      if (tmp < 60) {
        desc = "$tmp分钟前";
        break;
      }

      tmp = tmp ~/ 60;
      if (tmp < 24) {
        desc = "$tmp小时前";
        break;
      }

      tmp = tmp ~/ 24;
      if (tmp < 30) {
        desc = "$tmp天前";
        break;
      }

      tmp = tmp ~/ 30;
      if (tmp < 12) {
        desc = "$tmp月前";
        break;
      }

      tmp = tmp ~/ 12;
      desc = "$tmp年前";
      break;
    }

    return desc;
  }

  /// 时间戳转成事件字符串
  static String getDateString(int timestamp, String format) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat(format).format(date);
  }

}
