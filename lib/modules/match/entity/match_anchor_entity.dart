import 'package:wzty/modules/anchor/entity/live_list_entity.dart';

enum MatchAnchorType { living, more }

class MatchAnchorModel {
  List<LiveListModel> matchList;
  List<LiveListModel> otherMatchList;

  MatchAnchorModel({
    required this.matchList,
    required this.otherMatchList,
  });

  factory MatchAnchorModel.fromJson(Map<String, dynamic> json) {
    return MatchAnchorModel(
      matchList: List<LiveListModel>.from(
          (json['matchList'] ?? []).map((x) => LiveListModel.fromJson(x))),
      otherMatchList: List<LiveListModel>.from(
          (json['otherMatchList'] ?? []).map((x) => LiveListModel.fromJson(x))),
    );
  }
}
