class UserEntity {
  String uid;
  String userLevel;
  String ticket;
  String headImg;
  String nickName;
  String inviteUrl;
  String mobile;
  String username;
  int isRes;
  String agentName;
  String token;
  String? personalDesc;

  UserEntity({
    required this.uid,
    required this.userLevel,
    required this.ticket,
    required this.headImg,
    required this.nickName,
    required this.inviteUrl,
    required this.mobile,
    required this.username,
    required this.isRes,
    required this.agentName,
    required this.token,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        uid: json["uid"],
        userLevel: json["userLevel"],
        ticket: json["ticket"],
        headImg: json["headImg"],
        nickName: json["nickName"],
        inviteUrl: json["inviteUrl"],
        mobile: json["mobile"],
        username: json["username"],
        isRes: json["isRes"],
        agentName: json["agentName"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "userLevel": userLevel,
        "ticket": ticket,
        "headImg": headImg,
        "nickName": nickName,
        "inviteUrl": inviteUrl,
        "mobile": mobile,
        "username": username,
        "isRes": isRes,
        "agentName": agentName,
        "token": token,
      };

  getMobileDisplay() {
    if (mobile.length > 7) {
      return mobile.replaceRange(3, 4, "****");
    }
    return mobile;
  }
  
}
