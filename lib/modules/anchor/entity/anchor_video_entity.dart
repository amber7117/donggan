import 'package:wzty/utils/app_business_utils.dart';

class AnchorVideoModel {
  int roomRecordId;
  int matchId;
  int anchorId;
  String stb;
  int userId;
  String nickname;
  String headImageUrl;
  String profile;
  String systemDesc;
  int roomId;
  int chatId;
  String liveTitle;
  String recordImg;
  int anchorHot;
  int fans;
  String startTime;
  int totalTime;
  Map<String, String> playAddr;
  Map<String, String> recordAddr;

  late String totalTimeNew;

  AnchorVideoModel({
    required this.roomRecordId,
    required this.matchId,
    required this.anchorId,
    required this.stb,
    required this.userId,
    required this.nickname,
    required this.headImageUrl,
    required this.profile,
    required this.systemDesc,
    required this.roomId,
    required this.chatId,
    required this.liveTitle,
    required this.recordImg,
    required this.anchorHot,
    required this.fans,
    required this.startTime,
    required this.totalTime,
    required this.playAddr,
    required this.recordAddr,
  }) {
    if (totalTime > 0) {
      totalTimeNew = AppBusinessUtils.obtainVideoHMS(totalTime ~/ 1000);
    } else {
      totalTimeNew = "00:00:00";
    }
  }

  factory AnchorVideoModel.fromJson(Map<String, dynamic> json) {
    return AnchorVideoModel(
      roomRecordId: json['roomRecordId'] ?? 0,
      matchId: json['matchId'] ?? 0,
      anchorId: json['anchorId'] ?? 0,
      stb: json['stb'] ?? "",
      userId: json['userId'] ?? 0,
      nickname: json['nickname'] ?? "",
      headImageUrl: json['headImageUrl'] ?? "",
      profile: json['profile'] ?? "",
      systemDesc: json['systemDesc'] ?? "",
      roomId: json['roomId'] ?? 0,
      chatId: json['chatId'] ?? 0,
      liveTitle: json['liveTitle'] ?? "",
      recordImg: json['recordImg'] ?? "",
      anchorHot: json['anchorHot'] ?? 0,
      fans: json['fans'] ?? 0,
      startTime: json['startTime'] ?? "",
      totalTime: json['totalTime'] ?? 0,
      playAddr: json['playAddr'] != null
          ? Map<String, String>.from(json['playAddr'])
          : {},
      recordAddr: json['recordAddr'] != null
          ? Map<String, String>.from(json['recordAddr'])
          : {},
    );
  }
}
