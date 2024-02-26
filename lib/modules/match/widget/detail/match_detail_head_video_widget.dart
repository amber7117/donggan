import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/data/app_data_utils.dart';
import 'package:wzty/common/player/player_panel_match_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/anchor/widget/detail/login_timer_alert_widget.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MatchDetailHeadVideoWidget extends StatefulWidget {
  final VoidCallback? cb;
  final double height;
  final String urlStr;
  final String playerId;

  const MatchDetailHeadVideoWidget(
      {super.key,
      required this.height,
      required this.urlStr,
      required this.playerId, this.cb});

  @override
  State createState() => _MatchDetailHeadVideoWidgetState();
}

class _MatchDetailHeadVideoWidgetState
    extends State<MatchDetailHeadVideoWidget> {
  // -------------------------------------------

  final FijkPlayer player = FijkPlayer();

  late StreamSubscription _eventSub;
  late StreamSubscription loginEvent;

  @override
  void initState() {
    super.initState();

    _preparePlayVideo();

    _eventSub = eventBusManager.on<PlayerStatusEvent>((event) {
      if (mounted &&
          !player.value.fullScreen &&
          event.playerId == widget.playerId) {
        if (player.isPlayable() || player.state == FijkState.asyncPreparing) {
          event.pause ? player.pause() : player.start();
        }
      }
    });
    loginEvent = eventBusManager.on<LoginStatusEvent>((event) {
      if (event.login) {
        endLoginTimer();
      }
    });

    beginLoginTimer();
  }

  _preparePlayVideo() async {
    await player.setOption(FijkOption.formatCategory, "headers",
        "referer:https://video.dqiu.com/");
    player.setDataSource(widget.urlStr, autoPlay: true);
  }

  @override
  void dispose() {
    super.dispose();

    // todo 销毁好像有异常
    if (player.state == FijkState.started) {
      player.stop();
    }

    player.release();

    eventBusManager.off(_eventSub);

    endLoginTimer();

    eventBusManager.off(loginEvent);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height + ScreenUtil().statusBarHeight,
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: widget.height,
                child: _buildPlayerUI(),
              ),
              WZBackButton(cb: widget.cb),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPlayerUI() {
    FijkPanelWidgetBuilder builder =
        matchPanelBuilder(title: "", callback: (data) {});

    return FijkView(
      player: player,
      panelBuilder: builder,
      fit: FijkFit.ar16_9,
      fsFit: FijkFit.ar16_9,
      cover:
          AssetImage(JhImageUtils.obtainImgPath("anchor/imgLiveBg", x2: false)),
      color: Colors.black,
    );
  }

  // ----------------- Tool Method --------------------------

  bool getFullScreen() {
    return player.value.fullScreen;
  }

  void exitFullScreen() {
    player.exitFullScreen();
  }

  // ----------------- login timer --------------------------

  Timer? _loginTimer;
  bool _showTimerUI = false;

  void beginLoginTimer() {
    if (UserManager.instance.isLogin()) {
      return;
    }

    if (_loginTimer != null) {
      endLoginTimer();
    }

    if (AppDataUtils.instance.loginTimerCnt >= 60) {
      showTimerAlertUI(true);
      return;
    }
    
    _loginTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      AppDataUtils.instance.loginTimerCnt++;
      handleLoginTimerLogic();
    });
  }

  void endLoginTimer() {
    _loginTimer?.cancel();
    _loginTimer = null;
  }

  void handleLoginTimerLogic() {
    if (AppDataUtils.instance.loginTimerCnt == 24) {
      //两分钟
      showTimerAlertUI(false);
    } else if (AppDataUtils.instance.loginTimerCnt == 60) {
      //五分钟
      showTimerAlertUI(true);
      endLoginTimer();
    }
  }

  showTimerAlertUI(bool forceLogin) {
    if (_showTimerUI) {
      return;
    }
    _showTimerUI = true;

    bool isFullScreen = getFullScreen();
    if (isFullScreen) {
      exitFullScreen();

      Future.delayed(const Duration(milliseconds: 1000), () {
        _showLoginAlert(forceLogin);
      });
    } else {
      _showLoginAlert(forceLogin);
    }
  }

  _showLoginAlert(bool forceLogin) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context2) {
          return LoginTimerAlertWidget(
              forceLogin: forceLogin,
              callback: (login) {
                _showTimerUI = false;
                if (login) {
                  Routes.goLoginPage(context);
                }
              });
        });
  }
}
