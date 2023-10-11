class IMMsgFilterModel {
  bool success;
  String desc;
  String sign;
  String pushTime;

  IMMsgFilterModel({
    required this.success,
    required this.desc,
    required this.sign,
    required this.pushTime,
  });

  factory IMMsgFilterModel.fromJson(Map<String, dynamic> json) {
    return IMMsgFilterModel(
      success: json['success'] ?? false,
      desc: json['desc'] ?? "",
      sign: json['sign'] ?? "",
      pushTime: json['pushTime'] ?? "",
    );
  }
}
