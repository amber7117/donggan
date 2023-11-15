class PlayerDataManager {
  // ---------------------------------------------

  bool showVideoResolution = false;
  String resolution = "标清";
  List<String> titleArr = [];
  Map<String, String> playUrlDic = {};

  bool showDanmuSet = false;

  // ---------------------------------------------

  // ---------------------------------------------

  factory PlayerDataManager() => _getInstance;

  static PlayerDataManager get instance => _getInstance;

  static final PlayerDataManager _getInstance = PlayerDataManager._internal();

  PlayerDataManager._internal();
}
