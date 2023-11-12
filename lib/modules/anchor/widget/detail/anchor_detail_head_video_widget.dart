import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/player/player_panel_anchor_widget.dart';
import 'package:wzty/common/player/wz_player_manager.dart';
import 'package:wzty/common/widget/report_block_sheet_widget.dart';
import 'package:wzty/common/widget/report_sheet_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_manager.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class AnchorDetailHeadVideoWidget extends StatefulWidget {
  final double height;
  final String urlStr;
  final bool isAnchor;
  final String? titleStr;
  final AnchorDetailModel? detailModel;
  final String playerId;

  const AnchorDetailHeadVideoWidget(
      {super.key,
      required this.height,
      required this.urlStr,
      this.isAnchor = true,
      this.titleStr,
      this.detailModel,
      required this.playerId});

  @override
  State createState() => _AnchorDetailHeadVideoWidgetState();
}

class _AnchorDetailHeadVideoWidgetState
    extends State<AnchorDetailHeadVideoWidget> {
  // -------------------------------------------

  _showReporBlocktUI() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          List<ReportBlockType> dataArr = [
            ReportBlockType.reportLive,
            ReportBlockType.blockAnchor,
            ReportBlockType.blockLive
          ];
          return ReportBlockSheetWidget(
              dataArr: dataArr,
              callback: (data) {
                if (data == ReportBlockType.reportLive) {
                  _showReportUI();
                } else if (data == ReportBlockType.blockAnchor ||
                    data == ReportBlockType.blockLive) {
                  UserBlockManger.instance
                      .blockAnchor(model: widget.detailModel!);
                  ToastUtils.showSuccess("屏蔽成功");
                }
              });
        });
  }

  _showReportUI() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          List<String> dataArr = [
            "色情低俗",
            "未成年相关",
            "违规营销",
            "不实信息",
            "违法违规",
            "政治敏感",
          ];
          return ReportSheetWidget(
              dataArr: dataArr,
              callback: (data) {
                ToastUtils.showLoading();
                Future.delayed(const Duration(seconds: 2), () {
                  ToastUtils.showSuccess("举报成功");
                });
              });
        });
  }

  // -------------------------------------------

  handlePlayerEvent(PlayPanelEvent data) {
    if (data == PlayPanelEvent.more) {
      _showReporBlocktUI();
    } else if (data == PlayPanelEvent.fullScreen) {
    } else if (data == PlayPanelEvent.danmu) {}
  }

  // -------------------------------------------

  final FijkPlayer player = FijkPlayer();

  late StreamSubscription _eventSub;

  @override
  void initState() {
    super.initState();

    _requestData();

    player.setDataSource(widget.urlStr, autoPlay: true);

    _eventSub = eventBusManager.on<PlayerStatusEvent>((event) {
      if (mounted && event.playerId == widget.playerId) {
        if (player.isPlayable() || player.state == FijkState.asyncPreparing) {
          event.pause ? player.pause() : player.start();
        }
      }
    });
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
  }

  _requestData() {
    if (widget.detailModel == null) {
      return;
    }

    AnchorDetailModel model = widget.detailModel!;

    String resolution = "";
    List<String> titleArr = [];
    Map<String, String> playUrlDic = {};

    if (model.isRobot.isTrue()) {
      String title = "原画";
      titleArr.add(title);
      playUrlDic[title] = widget.urlStr;

      resolution = title;
    } else {
      List<String> tmpTitleArr = ["原画", "超清", "高清", "标清", "流畅", "自动"];
      List<String> tmpPrefixArr = ["ori", "ud", "hd", "sd", "ld", "ori"];

      for (int idx = 0; idx < tmpTitleArr.length; idx++) {
        String url = model.obtainVideoUrl(tmpPrefixArr[idx]);
        if (url.isNotEmpty) {
          titleArr.add(tmpTitleArr[idx]);
          playUrlDic[tmpTitleArr[idx]] = url;
        }
      }
      resolution = "标清";
    }

    WZPlayerManager.instance.showVideoResolution = false;
    WZPlayerManager.instance.showDanmuSet = false;

    WZPlayerManager.instance.resolution = resolution;
    WZPlayerManager.instance.titleArr = titleArr;
    WZPlayerManager.instance.playUrlDic = playUrlDic;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height + ScreenUtil().statusBarHeight,
      child: Column(
        children: [
          SizedBox(width: double.infinity, height: ScreenUtil().statusBarHeight)
              .colored(Colors.black),
          Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: widget.height,
                  child: _buildPlayerUI()),
              const WZBackButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPlayerUI() {
    FijkPanelWidgetBuilder builder =
        anchorPanelBuilder(title: widget.titleStr, callback: handlePlayerEvent);

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
}
