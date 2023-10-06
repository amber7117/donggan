class UserInfoEntity {
  String userId;
  int anchorId;
  String nickname;
  String headImgUrl;
  String personalDesc;
  int fansCount;
  int focusCount;
  bool isAttention;
  bool isFans;
  bool isAnchor;
  bool isAuthor;

  UserInfoEntity({
    required this.userId,
    required this.anchorId,
    required this.nickname,
    required this.headImgUrl,
    required this.personalDesc,
    required this.fansCount,
    required this.focusCount,
    required this.isAttention,
    required this.isFans,
    required this.isAnchor,
    required this.isAuthor,
  });

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) {
    return UserInfoEntity(
      userId: json['userId'].toString(),
      anchorId: json['anchorId'] ?? "",
      nickname: json['nickname'] ?? "",
      headImgUrl: json['headImgUrl'] ?? "",
      personalDesc: json['personalDesc'] ?? "",
      fansCount: json['fansCount'] ?? 0,
      focusCount: json['focusCount'] ?? 0,
      isAttention: json['isAttention'] ?? false,
      isFans: json['isFans'] ?? false,
      isAnchor: json['isAnchor'] ?? false,
      isAuthor: json['isAuthor'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'anchorId': anchorId,
      'nickname': nickname,
      'headImgUrl': headImgUrl,
      'personalDesc': personalDesc,
      'fansCount': fansCount,
      'focusCount': focusCount,
      'isAttention': isAttention,
      'isFans': isFans,
      'isAnchor': isAnchor,
      'isAuthor': isAuthor,
    };
  }
}
