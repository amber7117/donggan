import 'dart:async';

import 'package:wzty/app/app.dart';
import 'package:wzty/main/config/config_service.dart';
import 'package:wzty/main/config/live_block_entity.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/manager/match_collect_manager.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/utils/shared_preference_utils.dart';

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

  bool activeUserSwitch = false;
  bool activeUser = false;

  Timer? userTimer;
  Timer? userReportTimer;

  bool barrageOpen = false;
  void setBarrageOpen(bool value) {
    barrageOpen = value;
    SpUtils.save(SpKeys.barrageOpen, value);
  }

  int barrageFont = 0;
  void setBarrageFont(int value) {
    barrageFont = value;
    SpUtils.save(SpKeys.barrageFont, value);
  }

  double barrageOpacity = 0.0;
  void setBarrageOpacity(double value) {
    barrageOpacity = value;
    SpUtils.save(SpKeys.barrageOpacity, value);
  }

  // ---------------------------------------------

  bool videoIsBlock(int leagueId) {
    if (appDebug) {
      return false;
    }

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

  obtainData() async {
    activeUserSwitch = true;
    
    animateOk = await SpUtils.getBool(SpKeys.animateOK);
    videoOk = await SpUtils.getBool(SpKeys.videoOK);
    liveOk = await SpUtils.getBool(SpKeys.liveOK);

    barrageOpen = await SpUtils.getBool(SpKeys.barrageOpen);
    barrageFont = await SpUtils.getInt(SpKeys.barrageFont);
    if (barrageFont < 1) {
      barrageFont = 14;
    }
    barrageOpacity = await SpUtils.getDouble(SpKeys.barrageOpacity);
    if (barrageOpacity < 1) {
      barrageOpacity = 50.0;
    }

    eventSub = eventBusManager.on<LoginStatusEvent>((event) {
      _requestMatchFollowInfo();

      _judegeRequestUserActive();
    });
  }

  requestConfig() {
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

    ConfigService.requestLiveStatus((success, result) {
      if (success) {
        bool resultTmp = result;
        if (appDebug) {
          resultTmp = true;
        }
        if (liveOk != resultTmp) {
          liveOk = resultTmp;
          eventBusManager.emit(LiveStateEvent(liveOk: liveOk));
        }
        SpUtils.save(SpKeys.liveOK, liveOk);
      }
    });

    _requestMatchFollowInfo();

    Future animate = ConfigService.requestAnimateStatus((success, result) {
      if (success) {
        animateOk = result;
        if (appDebug) {
          animateOk = true;
        }
        SpUtils.save(SpKeys.animateOK, animateOk);
      }
    });

    Future video = ConfigService.requestVideoStatus((success, result) {
      if (success) {
        videoOk = result;
        if (appDebug) {
          videoOk = true;
        }
        SpUtils.save(SpKeys.videoOK, videoOk);
      }
    });

    Future.wait([animate, video]).then((value) {
      eventBusManager.emit(AnimateStateEvent(dataOk: true));
    });

    ConfigService.requestConfigInfo((success, result) {
      if (success) {
        contactQQ = result ?? "";
      }
    });

    ConfigService.requestChannelInfo((success, result) {
      if (success && result != null) {
        onlineKefu = result["echatUrl"];
        activeUserSwitch = result["activeUserSwitch"];
      }
      if (activeUserSwitch) {
        // 活跃逻辑
        _judegeRequestUserActive();
      } else {
        activeUser = true;
        eventBusManager.emit(ActiveUserEvent(activeUSer: true));
      }
    });
  }

  _requestMatchFollowInfo() {
    if (!UserManager.instance.isLogin()) {
      return;
    }
    
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

  // ----------------------  活跃用户逻辑  -----------------------

  void _judegeRequestUserActive() {
    if (!activeUserSwitch) return;

    // if (appDebug) {
    //   activeUser = true;
    // } else {
    _requestUserActive();
    // }
  }

  void _requestUserActive() {
    if (!UserManager.instance.isLogin()) {
      return;
    }

    logger.i('-----------_requestUserActive');

    ConfigService.requestUserActive((success, result) {
      if (success) {
        bool data = result;
        if (appDebug) {
          data = true;
        }

        if (activeUser != data) {
          activeUser = data;
          eventBusManager.emit(ActiveUserEvent(activeUSer: data));
        }

        beginUserTimer();
      }
    });
  }

  void _requestReportUserActive() {
    if (!UserManager.instance.isLogin()) {
      return;
    }

    ConfigService.requestReportUserActive((success, result) {});
  }

  void beginUserTimer() {
    if (userTimer != null || userReportTimer != null) {
      endUserTimer();
    }

    userReportTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      tickUserReportTimer();
    });

    if (!activeUser) {
      userTimer = Timer.periodic(const Duration(seconds: 10800), (timer) {
        tickUserTimer();
      });
    }
  }

  void endUserTimer() {
    userReportTimer?.cancel();
    userReportTimer = null;

    userTimer?.cancel();
    userTimer = null;
  }

  void tickUserReportTimer() {
    _requestReportUserActive();
  }

  void tickUserTimer() {
    _requestUserActive();
  }

  // ---------------------------------------------

  factory ConfigManager() => _getInstance;

  static ConfigManager get instance => _getInstance;

  static final ConfigManager _getInstance = ConfigManager._internal();

  ConfigManager._internal();
}
