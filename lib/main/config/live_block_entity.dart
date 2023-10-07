class LiveBlockModel {
  bool blockingByDeviceId;
  bool blockingByIp;
  List<int> blockingLeagueIds;

  LiveBlockModel({
    required this.blockingByDeviceId,
    required this.blockingByIp,
    required this.blockingLeagueIds,
  });

  factory LiveBlockModel.fromJson(Map<String, dynamic> json) {
    return LiveBlockModel(
      blockingByDeviceId: json['blockingByDeviceId'],
      blockingByIp: json['blockingByIp'],
      blockingLeagueIds: List<int>.from(json['blockingLeagueIds']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['blockingByDeviceId'] = blockingByDeviceId;
    data['blockingByIp'] = blockingByIp;
    data['blockingLeagueIds'] = blockingLeagueIds;
    return data;
  }
}
