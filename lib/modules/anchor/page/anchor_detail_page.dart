import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/data/app_data_utils.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/config/config_service.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_bottom_page.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_head_empty_widget.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_head_video_widget.dart';
import 'package:wzty/modules/anchor/widget/detail/login_timer_alert_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/page/match_detail_bottom_page.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_web_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';
import 'package:wzty/utils/wz_string_utils.dart';

class AnchorDetailPage extends StatefulWidget {
  final int anchorId;

  const AnchorDetailPage({super.key, required this.anchorId});

  @override
  State createState() => _AnchorDetailPageState();
}

class _AnchorDetailPageState
    extends KeepAliveLifeWidgetState<AnchorDetailPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  AnchorDetailModel? _model;
  AnchorDetailModel? _playInfo;

  late MatchDetailModel _matchDetailModel;

  final String playerId = WZStringUtils.generateRandomString(8);

  final GlobalKey<AnchorDetailBottomPageState> _detailBottomPageKey =
      GlobalKey();

  final GlobalKey<AnchorDetailHeadVideoWidgetState> _videoWidgetKey =
      GlobalKey();

  final ScrollController _scrollController = ScrollController();

  late StreamSubscription loginEvent;

  @override
  void initState() {
    super.initState();

    _requestData();

    loginEvent = eventBusManager.on<LoginStatusEvent>((event) {
      if (event.login) {
        endLoginTimer();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    endLoginTimer();
    endWatchTimer();

    eventBusManager.off(loginEvent);
  }

  @override
  void onPageResume() {
    super.onPageResume();

    if (_model != null) {
      eventBusManager.emit(PlayerStatusEvent(playerId: playerId, pause: false));
    }
  }

  @override
  void onPagePaused() {
    super.onPagePaused();

    if (_model != null) {
      eventBusManager.emit(PlayerStatusEvent(playerId: playerId, pause: true));
    }
  }

  _requestData() {
    ToastUtils.showLoading();

    Future basic = AnchorService.requestDetailBasicInfo(widget.anchorId,
        (success, result) {
      _model = result;
    });
    Future play =
        AnchorService.requestDetailPlayInfo(widget.anchorId, (success, result) {
      _playInfo = result;
    });

    Future.wait([basic, play]).then((value) {
      ToastUtils.hideLoading();

      if (_model != null && _playInfo != null) {
        _model!.updatePlayDataByModel(_playInfo!);

        _layoutState = LoadStatusType.success;

        requestAnchorMatchData();

        beginLoginTimer();
        beginWatchTimer();
      } else {
        _layoutState = LoadStatusType.failure;
      }

      setState(() {});
    });
  }

  void requestAnchorMatchData() {
    MatchDetailService.requestMatchDetail(_model!.matchId, (success, result) {
      if (result != null) {
        if (result.sportId == SportType.football.value ||
            result.sportId == SportType.basketball.value) {
          result.matchStatus = matchStatusToServerValue(MatchStatus.going);
          _matchDetailModel = result;

          _detailBottomPageKey.currentState?.showDataBtn();
        }
      }
    });
  }

  String _attemptPlayVideo() {
    // return "";
    if (_model == null) {
      return "";
    }

    AnchorDetailModel model = _model!;

    if (model.playAddr.isEmpty) {
      return "";
    }

    if (ConfigManager.instance.videoIsBlock(model.leagueId)) {
      return "";
    }

    String videoUrl = "";
    if (model.isRobot.isTrue()) {
      videoUrl = model.obtainVideoUrl("");
    } else {
      videoUrl = model.obtainVideoUrl("sd");
    }
    return videoUrl;
  }

  _matchDataBtnClick() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  _anchorDataBtnClick() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            errorRetry: _requestData,
            state: _layoutState,
            successWidget: _buildBottomUI()));
  }

  _buildBottomUI() {
    if (_model == null) {
      return const SizedBox();
    }

    AnchorDetailModel model = _model!;

    Widget headWidget;
    String videoUrl = _attemptPlayVideo();
    if (videoUrl.isNotEmpty) {
      headWidget = AnchorDetailHeadVideoWidget(
          key: _videoWidgetKey,
          height: videoHeight(),
          titleStr: model.liveTitle,
          urlStr: videoUrl,
          detailModel: model,
          playerId: playerId);
    } else if (model.animUrl.isNotEmpty) {
      headWidget = MatchDetailHeadWebWidget(
          height: videoHeight(), urlStr: model.animUrl);
    } else {
      headWidget = AnchorDetailHeadEmptyWidget(height: videoHeight());
    }
    return Column(
      children: [
        headWidget,
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 2,
              itemExtent: ScreenUtil().screenWidth,
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              cacheExtent: 0.0,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AnchorDetailBottomPage(
                      key: _detailBottomPageKey,
                      anchorId: widget.anchorId,
                      model: model,
                      callback: _matchDataBtnClick);
                } else {
                  return MatchDetailBottomPage(
                      matchId: _model!.matchId,
                      callback: _anchorDataBtnClick,
                      model: _matchDetailModel,
                      showChat: false);
                }
              }),
        )
      ],
    );
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }

  // ----------------- watch timer --------------------------

  Timer? _watchTimer;
  int _watchCnt = 0;

  void beginWatchTimer() {
    _watchTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _watchCnt += 30;
      _requestReportWatchTime();
    });
  }

  void endWatchTimer() {
    _watchTimer?.cancel();
    _watchTimer = null;
  }

  void _requestReportWatchTime() {
    ConfigService.requestReportWatchTime(
        widget.anchorId, _watchCnt, (success, result) {});
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

    if (_videoWidgetKey.currentState != null) {
      bool isFullScreen = _videoWidgetKey.currentState!.getFullScreen();
      if (isFullScreen) {
        _videoWidgetKey.currentState!.exitFullScreen();

        Future.delayed(const Duration(milliseconds: 1000), () {
          _showLoginAlert(forceLogin);
        });
      } else {
        _showLoginAlert(forceLogin);
      }
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
