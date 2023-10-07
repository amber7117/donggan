import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/entity/match_info_entity.dart';

class MatchCollectManager {
  factory MatchCollectManager() => _getInstance;

  static MatchCollectManager get instance => _getInstance;

  static final MatchCollectManager _getInstance =
      MatchCollectManager._internal();

  MatchCollectManager._internal();

  //---------------------------------------------

  List<MatchInfoModel> collectFBArr = [];
  List<MatchInfoModel> collectBBArr = [];

  //---------------------------------------------

  void setCollectData(SportType type, List<MatchInfoModel> data) {
    if (type == SportType.football) {
      collectFBArr = data;
    } else {
      collectBBArr = data;
    }
  }

  List<MatchInfoModel> obtainCollectData(SportType type) {
    List<MatchInfoModel> arrTmp = collectFBArr;
    if (type == SportType.basketball) {
      arrTmp = collectBBArr;
    }
    return arrTmp;
  }

  void updateCollectData(SportType type, MatchInfoModel match) {
    List<MatchInfoModel> arrTmp = obtainCollectData(type);

    if (match.focus) {
      arrTmp.add(match);
    } else {
      int dataIdx = -1;
      for (int idx = 0; idx < arrTmp.length; idx++) {
        if (arrTmp[idx].matchId == match.matchId) {
          dataIdx = idx;
          break;
        }
      }
      if (dataIdx != -1) {
        arrTmp.removeAt(dataIdx);
      }
    }

    if (type == SportType.football) {
      collectFBArr = arrTmp;
    } else {
      collectBBArr = arrTmp;
    }
  }

  int obtainCollectCount(SportType type) {
    List<MatchInfoModel> arrTmp = obtainCollectData(type);
    return arrTmp.length;
  }

  bool judgeMatchCollectStatus(SportType type, MatchInfoModel match) {
    List<MatchInfoModel> arrTmp = obtainCollectData(type);

    bool isCollect = false;
    for (MatchInfoModel model in arrTmp) {
      if (model.matchId == match.matchId) {
        isCollect = true;
        break;
      }
    }

    return isCollect;
  }
}
