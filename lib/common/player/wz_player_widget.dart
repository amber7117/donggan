import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:wzty/common/player/player_panel_anchor_widget.dart';
import 'package:wzty/common/player/custom_panel_match_widget.dart';
import 'package:wzty/common/player/custom_panel_playback_widget.dart';
import 'package:wzty/common/widget/report_block_sheet_widget.dart';
import 'package:wzty/common/widget/report_sheet_widget.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

enum WZPlayerType { match, anchor, playback }

class WZPlayerWidget extends StatefulWidget {
  final String? titleStr;
  final String urlStr;

  final WZPlayerType type;

  const WZPlayerWidget(
      {super.key, required this.urlStr, required this.type, this.titleStr});

  @override
  State createState() => _WZPlayerWidgetState();
}

class _WZPlayerWidgetState extends State<WZPlayerWidget> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();

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
  }

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
                } else if (data == ReportBlockType.reportLive) {
                } else if (data == ReportBlockType.reportLive) {}
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

  @override
  Widget build(BuildContext context) {
    FijkPanelWidgetBuilder builder;
    if (widget.type == WZPlayerType.match) {
      builder = matchPanelBuilder();
    } else if (widget.type == WZPlayerType.anchor) {
      builder = anchorPanelBuilder(
          title: widget.titleStr,
          callback: (data) {
            if (data == PlayPanelEvent.more) {
              _showReporBlocktUI();
            }
          });
    } else {
      builder = playbackPanelBuilder();
    }

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
