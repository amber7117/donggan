import 'package:flutter/material.dart';
import 'package:wzty/common/player/player_danmu_widget.dart';

class WZPlayerManager {
  // ---------------------------------------------

  bool showVideoResolution = false;
  String resolution = "标清";
  List<String> titleArr = [];
  Map<String, String> playUrlDic = {};

  bool showDanmuSet = false;

  Widget? _danmuWidget;
  Widget getDanmuWidget() {
    _danmuWidget ??= const PlayerDanmuWidget(); 
    return _danmuWidget!;
  }


  // ---------------------------------------------

  // ---------------------------------------------

  factory WZPlayerManager() => _getInstance;

  static WZPlayerManager get instance => _getInstance;

  static final WZPlayerManager _getInstance = WZPlayerManager._internal();

  WZPlayerManager._internal();
}
