class AnchorListModel {
  int anchorId;

  int userId;
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
  int isAttention;

  AnchorListModel({
    required this.anchorId,
    required this.userId,
    required this.nickName,
    required this.headImageUrl,
    required this.title,
    required this.roomImg,
    required this.anchorHot,
    required this.liveType,
    required this.isRobot,
    required this.isGreenLive,
    required this.fans,
    required this.isAttention,
  });

  factory AnchorListModel.fromJson(Map<String, dynamic> json) {
    return AnchorListModel(
      anchorId: json['anchorId'] ?? 0,
      userId: json['userId'] ?? 0,
      nickName: json['nickName'] ?? (json['nickname'] ?? ""),
      headImageUrl: json['headImageUrl'] ?? (json['liveHeadImage'] ?? ""),
      title: json['title'] ?? (json['liveTitle'] ?? ""),
      roomImg: json['roomImg'] ?? (json['liveImage'] ?? ""),
      anchorHot: json['anchorHot'] ?? 0,
      liveType: json['liveType'] ?? 0,
      isRobot: json['isRobot'] ?? 0,
      isGreenLive: json['isGreenLive'] ?? 0,
      fans: json['fans'] ?? 0,
      isAttention: json['isAttention'] ?? 0,
    );
  }
}
