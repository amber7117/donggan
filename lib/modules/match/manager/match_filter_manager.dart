import 'package:wzty/app/app.dart';

class MatchFilterManager {
  // ---------------------------------------------

  SportType sportType = SportType.football;
  MatchStatus matchStatus = MatchStatus.unknown;
  MatchFilterType filterType = MatchFilterType.unknown;

  List<int> leagueIdArr = [];
  Map<MatchFilterType, Map<MatchStatus, dynamic>> fbFilterData = {};
  Map<MatchFilterType, Map<MatchStatus, dynamic>> bbFilterData = {};

  // ---------------------------------------------

  void updateFilterData(SportType sportType, MatchFilterType filterType,
      MatchStatus matchStatus, List<int> data) {
    Map<MatchStatus, dynamic>? matchStatusDic =
        getMatchStatusDic(sportType, filterType);

    matchStatusDic ??= {};

    matchStatusDic[matchStatus] = data;

    if (sportType == SportType.football) {
      fbFilterData[filterType] = matchStatusDic;
    } else {
      bbFilterData[filterType] = matchStatusDic;
    }

    this.filterType = filterType;
    leagueIdArr = data;
  }

  List<int> obtainFilterData(SportType sportType, MatchFilterType filterType,
      MatchStatus matchStatus) {
    Map<MatchStatus, dynamic>? matchStatusDic =
        getMatchStatusDic(sportType, filterType);

    if (matchStatusDic != null && matchStatusDic[matchStatus] != null) {
      return matchStatusDic[matchStatus] as List<int>;
    }
    return [];
  }

  Map<MatchStatus, dynamic>? getMatchStatusDic(
      SportType sportType, MatchFilterType filterType) {
    Map<MatchStatus, dynamic>? matchStatusDic;
    if (sportType == SportType.football) {
      matchStatusDic = fbFilterData[filterType];
    } else {
      matchStatusDic = bbFilterData[filterType];
    }
    return matchStatusDic;
  }

  // ---------------------------------------------

  factory MatchFilterManager() => _getInstance;

  static MatchFilterManager get instance => _getInstance;

  static final MatchFilterManager _getInstance = MatchFilterManager._internal();

  MatchFilterManager._internal();
}
