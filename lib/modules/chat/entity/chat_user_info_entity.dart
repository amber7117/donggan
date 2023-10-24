class ChatUserInfo {
  int userId;
  String nickname;
  String headImgUrl;
  int isAdmin;
  int isAnchor;
  int isRoomManager;
  int isMute;
  int isBlock;
  int isInternalUser;

  ChatUserInfo({
    required this.userId,
    required this.nickname,
    required this.headImgUrl,
    required this.isAdmin,
    required this.isAnchor,
    required this.isRoomManager,
    required this.isMute,
    required this.isBlock,
    required this.isInternalUser,
  });

  factory ChatUserInfo.fromJson(Map<String, dynamic> json) {
    return ChatUserInfo(
      userId: json['userId'] ?? 0,
      nickname: json['nickname'] ?? "",
      headImgUrl: json['headImgUrl'] ?? "",
      isAdmin: json['isAdmin'] ?? 0,
      isAnchor: json['isAnchor'] ?? 0,
      isRoomManager: json['isRoomManager'] ?? 0,
      isMute: json['isMute'] ?? 0,
      isBlock: json['isBlock'] ?? 0,
      isInternalUser: json['isInternalUser'] ?? 0,
    );
  }

  bool isRoot() {
    return isRoomManager == 1 || isAdmin == 1 || isAnchor == 1;
  }
}
