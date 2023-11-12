import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/player/wz_player_manager.dart';
import 'package:wzty/common/player/wz_player_widget.dart';
import 'package:wzty/common/widget/report_block_sheet_widget.dart';
import 'package:wzty/common/widget/report_sheet_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_manager.dart';
import 'package:wzty/utils/toast_utils.dart';

class AnchorDetailHeadVideoWidget extends StatefulWidget {
  final double height;
  final String urlStr;
  final bool isAnchor;
  final String? titleStr;
  final AnchorDetailModel? detailModel;

  const AnchorDetailHeadVideoWidget(
      {super.key,
      required this.height,
      required this.urlStr,
      this.isAnchor = true,
      this.titleStr,
      this.detailModel});

  @override
  State createState() => _AnchorDetailHeadVideoWidgetState();
}

class _AnchorDetailHeadVideoWidgetState
    extends State<AnchorDetailHeadVideoWidget> {
  @override
  void initState() {
    super.initState();

    _requestData();
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

    WZPlayerManager.instance.resolution = resolution;
    WZPlayerManager.instance.url = widget.urlStr;

    WZPlayerManager.instance.titleArr = titleArr;
    WZPlayerManager.instance.playUrlDic = playUrlDic;
  }

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
    } else if (data == PlayPanelEvent.resolution) {
    } else if (data == PlayPanelEvent.danmu) {
    } else if (data == PlayPanelEvent.danmuSet) {}
  }

  // -------------------------------------------

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
                child: WZPlayerWidget(
                  urlStr: widget.urlStr,
                  titleStr: widget.titleStr,
                  type: widget.isAnchor
                      ? WZPlayerType.anchor
                      : WZPlayerType.playback,
                  callback: handlePlayerEvent,
                ),
              ),
              const WZBackButton(),
            ],
          )
        ],
      ),
    );
  }
}
