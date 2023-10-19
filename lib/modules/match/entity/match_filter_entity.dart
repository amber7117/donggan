class MatchFilterModel {
  List<MatchFilterItemModel> hotAr = [];
  int totalCount = 0;
  List<String> titleArr = [];
  List<List<MatchFilterItemModel>> moderArrArr = [];

  MatchFilterModel();

}


class MatchFilterItemModel {
  int id;
  String cnAlias;
  String headLetter;
  int matchCount;
  bool isHot;
  bool noSelect;

  MatchFilterItemModel({
    required this.id,
    required this.cnAlias,
    required this.headLetter,
    required this.matchCount,
    required this.isHot,
    this.noSelect = false,
  });

  factory MatchFilterItemModel.fromJson(Map<String, dynamic> json) {
    return MatchFilterItemModel(
      id: json['id'] ?? 0,
      cnAlias: json['cnAlias'] ?? "",
      headLetter: json['headLetter'] ?? "",
      matchCount: json['matchCount'] ?? 0,
      isHot: json['isHot'] ?? false,
    );
  }

}
