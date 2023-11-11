class AnchorDetailModel {
  int leagueId;
  int matchId;
  int anchorId;
  String stb;
  int userId;
  String nickname;
  String headImageUrl;
  String profile;
  String systemDesc;
  int roomId;
  String chatId;
  String liveTitle;
  int anchorHot;
  int fans;
  int isShow;
  int status;
  int fansType;
  int isRobot;
  Map<String, String> playAddr;
  Map<String, String> recordAddr;
  String animUrl;

  AnchorDetailModel({
    required this.leagueId,
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
    required this.anchorHot,
    required this.fans,
    required this.isShow,
    required this.status,
    required this.fansType,
    required this.isRobot,
    required this.playAddr,
    required this.recordAddr,
    required this.animUrl,
  });

  factory AnchorDetailModel.fromJson(Map<String, dynamic> json) {
    return AnchorDetailModel(
      leagueId: json['leagueId'] ?? 0,
      matchId: json['matchId'] ?? 0,
      anchorId: json['anchorId'] ?? 0,
      stb: json['stb'] ?? '',
      userId: json['userId'] ?? 0,
      nickname: json['nickname'] ?? '',
      headImageUrl: json['headImageUrl'] ?? '',
      profile: json['profile'] ?? '',
      systemDesc: json['systemDesc'] ?? '',
      roomId: json['roomId'] ?? 0,
      chatId: json['chatId'] ?? '',
      liveTitle: json['liveTitle'] ?? '',
      anchorHot: json['anchorHot'] ?? 0,
      fans: json['fans'] ?? 0,
      isShow: json['isShow'] ?? 0,
      status: json['status'] ?? 0,
      fansType: json['fansType'] ?? 0,
      isRobot: json['isRobot'] ?? 0,
      playAddr: json['playAddr'] != null
          ? Map<String, String>.from(json['playAddr'])
          : {},
      recordAddr: json['recordAddr'] != null
          ? Map<String, String>.from(json['recordAddr'])
          : {},
      animUrl: json['animUrl'] ?? '',
    );
  }

  void updatePlayDataByModel(AnchorDetailModel model) {
    liveTitle = model.liveTitle;
    playAddr = model.playAddr;
    animUrl = model.animUrl;
    chatId = model.chatId;
  }

  void updatePlaybackDataByModel(AnchorRecordModel model) {
    liveTitle = model.title;
    recordAddr = model.recordAddr;
  }

  String obtainVideoUrl(String prefix) {
    String videoUrl = "";
    String key1 = "";
    String key2 = "";
    String key3 = "";

    if (prefix.isNotEmpty) {
      key1 = "${prefix}_flv";
      key2 = "${prefix}_m3u8";
      key3 = "${prefix}_rtmp";
    } else {
      key1 = "flv";
      key2 = "m3u8";
      key3 = "rtmp";
    }

    if (playAddr.containsKey(key1)) {
      videoUrl = playAddr[key1]!;
    } else if (playAddr.containsKey(key2)) {
      videoUrl = playAddr[key2]!;
    } else if (playAddr.containsKey(key3)) {
      videoUrl = playAddr[key3]!;
    }

    return videoUrl;
  }
}


class AnchorRecordModel {
  String title;
  Map<String, String> recordAddr;

  AnchorRecordModel({
    required this.title,
    required this.recordAddr,
  });

  factory AnchorRecordModel.fromJson(Map<String, dynamic> json) {
    return AnchorRecordModel(
      title: json['title'] ?? '',
      recordAddr: json['recordAddr'] != null
          ? Map<String, String>.from(json['recordAddr'])
          : {},
    );
  }

}
