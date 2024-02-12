class AnchorCategoryModel {
  int liveGroupId;
  String liveGroupName;
  int liveGroupSort;
  int groupStatus;

  AnchorCategoryModel({
    required this.liveGroupId,
    required this.liveGroupName,
    required this.liveGroupSort,
    required this.groupStatus,
  });

  factory AnchorCategoryModel.fromJson(Map<String, dynamic> json) {
    return AnchorCategoryModel(
      liveGroupId: json['liveGroupId'] ?? 0,
      liveGroupName: json['liveGroupName'] ?? "",
      liveGroupSort: json['liveGroupSort'] ?? 0,
      groupStatus: json['groupStatus'] ?? 0,
    );
  }

  factory AnchorCategoryModel.empty() {
    return AnchorCategoryModel(
      liveGroupId: 0,
      liveGroupName: "推荐",
      liveGroupSort: 0,
      groupStatus: 0,
    );
  }
}
