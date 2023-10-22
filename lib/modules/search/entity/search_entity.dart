import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';


class SearchResultModel {
  List<MatchListModel> matchList;
  List<AnchorListModel> anchors;
  // List<SearchTeamModel> teamList;

  SearchResultModel({
    required this.matchList,
    required this.anchors,
    // required this.teamList,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        matchList: List<MatchListModel>.from(
            json['matchList']?.map((x) => MatchListModel.fromJson(x)) ?? []),
        anchors: List<AnchorListModel>.from(
            json['anchors']?.map((x) => AnchorListModel.fromJson(x)) ?? []),
        // teamList: List<SearchTeamModel>.from(
        //     json['teamList']?.map((x) => SearchTeamModel.fromJson(x)) ??
        //         []),
      );
}


class SearchTeamModel {
  int sportId;
  int teamId;
  String teamName;
  String teamLogo;

  SearchTeamModel({
    required this.sportId,
    required this.teamId,
    required this.teamName,
    required this.teamLogo,
  });

  factory SearchTeamModel.fromJson(Map<String, dynamic> json) =>
      SearchTeamModel(
        sportId: json['sportId'] ?? 0,
        teamId: json['teamId'] ?? 0,
        teamName: json['teamName'] ?? '',
        teamLogo: json['teamLogo'] ?? '',
      );
}
