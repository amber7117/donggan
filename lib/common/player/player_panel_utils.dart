import 'dart:collection';

String duration2String(Duration duration) {
  if (duration.inMilliseconds < 0) return "-: negtive";

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  int inHours = duration.inHours;
  return inHours > 0
      ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
      : "$twoDigitMinutes:$twoDigitSeconds";
}

String twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}

class WZFijkData {
  static String fijkViewPanelVolume = "__fijkview_panel_init_volume";
  static String fijkViewPanelBrightness = "__fijkview_panel_init_brightness";
  static String fijkViewPanelSeekto = "__fijkview_panel_sekto_position";

  final Map<String, dynamic> _data = HashMap();

  void setValue(String key, dynamic value) {
    _data[key] = value;
  }

  void clearValue(String key) {
    _data.remove(key);
  }

  bool contains(String key) {
    return _data.containsKey(key);
  }

  dynamic getValue(String key) {
    return _data[key];
  }
}
