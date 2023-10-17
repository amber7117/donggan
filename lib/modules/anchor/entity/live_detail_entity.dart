class LiveDetailModel {
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

  LiveDetailModel({
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

  factory LiveDetailModel.fromJson(Map<String, dynamic> json) {
    return LiveDetailModel(
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

  void updatePlayDataByModel(LiveDetailModel model) {
    liveTitle = model.liveTitle;
    playAddr = model.playAddr;
    animUrl = model.animUrl;
    chatId = model.chatId;
  }

  void updatePlaybackDataByModel(LiveRecordModel model) {
    liveTitle = model.title;
    recordAddr = model.recordAddr;
  }

}


class LiveRecordModel {
  String title;
  Map<String, String> recordAddr;

  LiveRecordModel({
    required this.title,
    required this.recordAddr,
  });

  factory LiveRecordModel.fromJson(Map<String, dynamic> json) {
    return LiveRecordModel(
      title: json['title'] ?? '',
      recordAddr: json['recordAddr'] != null
          ? Map<String, String>.from(json['recordAddr'])
          : {},
    );
  }

}
