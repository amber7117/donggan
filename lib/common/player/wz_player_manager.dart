class WZPlayerManager {
  // ---------------------------------------------

  bool showVideoResolution = false;
  String resolution = "标清";
  late String url;
  List<String> titleArr = [];
  Map<String, String> playUrlDic = {};

  bool showDanmuSet = false;

  // ---------------------------------------------

  // ---------------------------------------------

  factory WZPlayerManager() => _getInstance;

  static WZPlayerManager get instance => _getInstance;

  static final WZPlayerManager _getInstance = WZPlayerManager._internal();

  WZPlayerManager._internal();
}
