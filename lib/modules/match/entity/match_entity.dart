import 'package:wzty/modules/match/entity/match_info_entity.dart';

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
      going: json['going'] != null
          ? MatchSubModel.fromJson(json['going'])
          : null,
      unknown: json['unknown'] != null
          ? MatchSubModel.fromJson(json['unknown'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (finished != null) {
      data['finished'] = finished?.toJson();
    }
    if (uncoming != null) {
      data['uncoming'] = uncoming?.toJson();
    }
    if (going != null) {
      data['going'] = going?.toJson();
    }
    if (unknown != null) {
      data['unknown'] = unknown?.toJson();
    }
    return data;
  }
}

class MatchSubModel {
  int count;
  List<MatchInfoModel> matches;

  MatchSubModel({
    required this.count,
    required this.matches,
  });

  factory MatchSubModel.fromJson(Map<String, dynamic> json) {
    return MatchSubModel(
      count: json['count'],
      matches: json['matches'] != null
          ? List<MatchInfoModel>.from(
              json['matches'].map((x) => MatchInfoModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    data['matches'] = List<dynamic>.from(matches.map((x) => x.toJson()));
    return data;
  }
}
