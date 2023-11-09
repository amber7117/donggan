class UserBlockEntity {
  int userId;
  String headImgUrl;
  String nickName;
  int fansCount;
  bool removedBlock;

  UserBlockEntity({
    this.userId = 0,
    this.headImgUrl = '',
    this.nickName = '',
    this.fansCount = 0,
    this.removedBlock = false,
  });

  factory UserBlockEntity.fromJson(Map<String, dynamic> json) {
    return UserBlockEntity(
      userId: json['userId'] ?? 0,
      headImgUrl: json['headImgUrl'] ?? '',
      nickName: json['nickName'] ?? '',
      fansCount: json['fansCount'] ?? 0,
      removedBlock: json['removedBlock'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'headImgUrl': headImgUrl,
      'nickName': nickName,
      'fansCount': fansCount,
      'removedBlock': removedBlock,
    };
  }
}
