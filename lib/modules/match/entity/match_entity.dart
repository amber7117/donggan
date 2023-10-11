import 'package:wzty/modules/match/entity/match_list_entity.dart';

class MatchModel {
  MatchSubModel? finished;
  MatchSubModel? uncoming;
  MatchSubModel? going;
  MatchSubModel? unknown;

  MatchModel({
    required this.finished,
    required this.uncoming,
    required this.going,
    required this.unknown,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      finished: json['finished'] != null
          ? MatchSubModel.fromJson(json['finished'])
          : null,
      uncoming: json['uncoming'] != null
          ? MatchSubModel.fromJson(json['uncoming'])
          : null,
      going:
          json['going'] != null ? MatchSubModel.fromJson(json['going']) : null,
      unknown: json['unknown'] != null
          ? MatchSubModel.fromJson(json['unknown'])
          : null,
    );
  }
}

class MatchSubModel {
  int count;
  List<MatchListModel> matches;

  MatchSubModel({
    required this.count,
    required this.matches,
  });

  factory MatchSubModel.fromJson(Map<String, dynamic> json) {
    return MatchSubModel(
      count: json['count'],
      matches: json['matches'] != null
          ? List<MatchListModel>.from(
              json['matches'].map((x) => MatchListModel.fromJson(x)))
          : [],
    );
  }
}
