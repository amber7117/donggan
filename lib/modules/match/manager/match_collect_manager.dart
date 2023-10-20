import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';

class MatchCollectManager {
  // ---------------------------------------------

  List<MatchListModel> collectFBArr = [];
  List<MatchListModel> collectBBArr = [];

  // ---------------------------------------------

  int setCollectData(SportType type, List<MatchListModel> data) {
    if (type == SportType.football) {
      collectFBArr = data;
    } else {
      collectBBArr = data;
    }
    return data.length;
  }

  List<MatchListModel> obtainCollectData(SportType type) {
    List<MatchListModel> arrTmp = collectFBArr;
    if (type == SportType.basketball) {
      arrTmp = collectBBArr;
    }
    return arrTmp;
  }

  int updateCollectData(SportType type, MatchListModel match) {
    List<MatchListModel> arrTmp = obtainCollectData(type);

    if (match.focus) {
      arrTmp.insert(0, match);
    } else {
      arrTmp.removeWhere((element) => element.matchId == match.matchId);
    }

    if (type == SportType.football) {
      collectFBArr = arrTmp;
    } else {
      collectBBArr = arrTmp;
    }

    return arrTmp.length;
  }

  int obtainCollectCount(SportType type) {
    List<MatchListModel> arrTmp = obtainCollectData(type);
    return arrTmp.length;
  }

  bool judgeMatchCollectStatus(SportType type, MatchListModel match) {
    List<MatchListModel> arrTmp = obtainCollectData(type);

    bool isCollect = false;
    for (MatchListModel model in arrTmp) {
      if (model.matchId == match.matchId) {
        isCollect = true;
        break;
      }
    }

    return isCollect;
  }

  // ---------------------------------------------

  factory MatchCollectManager() => _getInstance;

  static MatchCollectManager get instance => _getInstance;

  static final MatchCollectManager _getInstance =
      MatchCollectManager._internal();

  MatchCollectManager._internal();
}
