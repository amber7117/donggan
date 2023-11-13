import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/player/player_panel_match_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MatchDetailHeadVideoWidget extends StatefulWidget {
  final double height;
  final String urlStr;
  final String playerId;

  const MatchDetailHeadVideoWidget(
      {super.key,
      required this.height,
      required this.urlStr,
      required this.playerId});

  @override
  State createState() => _MatchDetailHeadVideoWidgetState();
}

class _MatchDetailHeadVideoWidgetState
    extends State<MatchDetailHeadVideoWidget> {
  // -------------------------------------------

  final FijkPlayer player = FijkPlayer();

  late StreamSubscription _eventSub;

  @override
  void initState() {
    super.initState();

    _preparePlayVideo();

    _eventSub = eventBusManager.on<PlayerStatusEvent>((event) {
      if (mounted && event.playerId == widget.playerId) {
        if (player.isPlayable() || player.state == FijkState.asyncPreparing) {
          event.pause ? player.pause() : player.start();
        }
      }
    });
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
              const WZBackButton(),
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
}
