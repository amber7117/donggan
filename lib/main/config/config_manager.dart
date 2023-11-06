import 'dart:async';

import 'package:wzty/app/app.dart';
import 'package:wzty/main/config/config_service.dart';
import 'package:wzty/main/config/live_block_entity.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/modules/match/manager/match_collect_manager.dart';
import 'package:wzty/modules/match/service/match_service.dart';

class ConfigManager {
  // ---------------------------------------------

  late StreamSubscription eventSub;
  
  // ---------------------------------------------

  LiveBlockModel? liveBlockData;

  String systemNotice = "";

  bool animateOk = false;

  bool videoOk = false;

  bool liveOk = false;

  String contactQQ = "";

  String onlineKefu = "";

  bool activeUser = false;

  Timer? userTimer;
  Timer? userReportTimer;

  // ---------------------------------------------
  
  bool videoIsBlock(int leagueId) {
    if (!liveOk) {
      return true;
    }

    if (liveBlockData == null) {
      return true;
    }

    if (liveBlockData!.blockingByDeviceId || liveBlockData!.blockingByIp) {
      return true;
    }

    if (liveBlockData!.blockingLeagueIds.contains(leagueId)) {
      return true;
    }

    return false;
  }

  // ---------------------------------------------
  
  requestConfig() {
     eventSub = eventBusManager.on<LoginStatusEvent>((event) {
        _requestMatchFollowInfo();
     });

    ConfigService.requestLiveBlock((success, result) {
      if (success) {
        liveBlockData = result;
      }
    });

    ConfigService.requestSystemNotice((success, result) {
      if (success) {
        systemNotice = result!;
      }
    });

    ConfigService.requestAnimateStatus((success, result) {
      if (success) {
        animateOk = result!;
        if (appDebug) {
          animateOk = true;
        }
      }
    });

    ConfigService.requestVideoStatus((success, result) {
      if (success) {
        videoOk = result!;
        if (appDebug) {
          videoOk = true;
        }
      }
    });

    ConfigService.requestLiveStatus((success, result) {
      if (success) {
        liveOk = result!;
        if (appDebug) {
          liveOk = true;
        }
      }
    });

    _requestMatchFollowInfo();

    ConfigService.requestConfigInfo((success, result) {
      if (success) {
        contactQQ = result ?? "";
      }
    });

    ConfigService.requestChannelInfo((success, result) {
      if (success) {
        onlineKefu = result ?? "";
      }
    });
  }

  _requestMatchFollowInfo() {
    MatchService.requestMatchListAttr(SportType.football, (success, result) {
      if (success) {
        int cnt = MatchCollectManager.instance
            .setCollectData(SportType.football, result);
        eventBusManager.emit(
            MatchCollectDataEvent(sportType: SportType.football, value: cnt));
      }
    });

    MatchService.requestMatchListAttr(SportType.basketball, (success, result) {
      if (success) {
        int cnt = MatchCollectManager.instance
            .setCollectData(SportType.basketball, result);
        eventBusManager.emit(
            MatchCollectDataEvent(sportType: SportType.basketball, value: cnt));
      }
    });
  }

  // ---------------------------------------------

  factory ConfigManager() => _getInstance;

  static ConfigManager get instance => _getInstance;

  static final ConfigManager _getInstance = ConfigManager._internal();

  ConfigManager._internal(
   
  );
}
