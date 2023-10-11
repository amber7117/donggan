class LiveListModel {
  int anchorId;
  String nickName;
  // String nickname;
  String headImageUrl;
  // String liveHeadImage;
  String title;
  // String liveTitle;
  String roomImg;
  // String liveImage;
  int anchorHot;
  int liveType;
  int isRobot;
  int isGreenLive;
  int fans;

  LiveListModel({
    required this.anchorId,
    required this.nickName,
    required this.headImageUrl,
    required this.title,
    required this.roomImg,
    required this.anchorHot,
    required this.liveType,
    required this.isRobot,
    required this.isGreenLive,
    required this.fans,
  });

  factory LiveListModel.fromJson(Map<String, dynamic> json) {
    return LiveListModel(
      anchorId: json['anchorId'] ?? 0,
      nickName: json['nickName'] ?? (json['nickname'] ?? ""),
      headImageUrl: json['headImageUrl'] ?? (json['liveHeadImage'] ?? ""),
      title: json['title'] ?? (json['liveTitle'] ?? ""),
      roomImg: json['roomImg'] ?? (json['liveImage'] ?? ""),
      anchorHot: json['anchorHot'] ?? 0,
      liveType: json['liveType'] ?? 0,
      isRobot: json['isRobot'] ?? 0,
      isGreenLive: json['isGreenLive'] ?? 0,
      fans: json['fans'] ?? 0,
    );
  }
}
