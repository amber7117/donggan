import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';

enum MatchAnchorType { living, more }

class MatchAnchorModel {
  List<AnchorListModel> matchList;
  List<AnchorListModel> otherMatchList;

  MatchAnchorModel({
    required this.matchList,
    required this.otherMatchList,
  });

  factory MatchAnchorModel.fromJson(Map<String, dynamic> json) {
    return MatchAnchorModel(
      matchList: List<AnchorListModel>.from(
          (json['matchList'] ?? []).map((x) => AnchorListModel.fromJson(x))),
      otherMatchList: List<AnchorListModel>.from(
          (json['otherMatchList'] ?? []).map((x) => AnchorListModel.fromJson(x))),
    );
  }
}
