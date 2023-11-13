import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/entity/anchor_video_entity.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_bottom_page.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_head_empty_widget.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_head_video_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_web_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class LivePlaybackPage extends StatefulWidget {
  final AnchorVideoModel videoModel;

  const LivePlaybackPage({super.key, required this.videoModel});

  @override
  State createState() => _LivePlaybackPageState();
}

class _LivePlaybackPageState extends State<LivePlaybackPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  
  AnchorDetailModel? _model;
  AnchorRecordModel? _playInfo;

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  _requestData() {
    AnchorVideoModel model = widget.videoModel;

    ToastUtils.showLoading();

    Future basic =
        AnchorService.requestDetailBasicInfo(model.anchorId, (success, result) {
      _model = result;
    });
    Future play = AnchorService.requestPlaybackInfo(
        model.anchorId, model.roomRecordId, (success, result) {
      _playInfo = result;
    });

    Future.wait([basic, play]).then((value) {
      ToastUtils.hideLoading();

      if (_model != null && _playInfo != null) {
        _model!.updatePlaybackDataByModel(_playInfo!);

        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.empty;
      }

      setState(() {});
    });
  }

  String _attempPlayPlayback() {
    late AnchorDetailModel model;
    if (_model == null) {
      return "";
    }

    model = _model!;

    if (model.recordAddr.isEmpty) {
      return "";
    }

    if (ConfigManager.instance.videoIsBlock(model.leagueId)) {
      return "";
    }

    return model.recordAddr["m3u8"] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }

    AnchorDetailModel model = _model!;

    Widget headWidget;
    String videoUrl = _attempPlayPlayback();
    if (videoUrl.isNotEmpty) {
      headWidget = AnchorDetailHeadVideoWidget(
          height: videoHeight(),
          titleStr: model.liveTitle,
          urlStr: videoUrl,
          isAnchor: false,
          playerId: "");
    } else if (_model!.animUrl.isNotEmpty) {
      headWidget = MatchDetailHeadWebWidget(
          height: videoHeight(), urlStr: _model!.animUrl);
    } else {
      headWidget = AnchorDetailHeadEmptyWidget(height: videoHeight());
    }

    return Column(
      children: [
        headWidget,
        Expanded(
          child: AnchorDetailBottomPage(
              anchorId: model.anchorId, model: model, showChat: false),
        )
      ],
    );
  }
}
