import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_bottom_page.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_head_empty_widget.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_head_video_widget.dart';
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
  final GlobalKey<MatchDetailBottomPageState> _matchDataPageKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _requestData();
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
    _matchDataPageKey.currentState?.setDetailModel(_matchDetailModel);

    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  _anchorDataBtnClick() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248,
            // resizeToAvoidBottomInset: false,
            body: _buildBottomUI()));
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
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AnchorDetailBottomPage(
                      key: _detailBottomPageKey,
                      anchorId: widget.anchorId,
                      model: model,
                      callback: _matchDataBtnClick);
                } else {
                  return MatchDetailBottomPage(
                      key: _matchDataPageKey,
                      matchId: _model!.matchId,
                      callback: _anchorDataBtnClick,
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
}
