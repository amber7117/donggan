import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/player/player_panel_anchor_widget.dart';
import 'package:wzty/common/player/player_panel_match_widget.dart';
import 'package:wzty/common/player/player_panel_playback_widget.dart';
import 'package:wzty/utils/jh_image_utils.dart';

enum WZPlayerType { match, anchor, playback }

class WZPlayerWidget extends StatefulWidget {
  final String? titleStr;
  final String urlStr;

  final WZPlayerType type;

  final WZAnyCallback<PlayPanelEvent>? callback;

  const WZPlayerWidget(
      {super.key,
      this.titleStr,
      required this.urlStr,
      required this.type,
      this.callback});

  @override
  State createState() => WZPlayerWidgetState();
}

class WZPlayerWidgetState extends State<WZPlayerWidget> {
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

  @override
  Widget build(BuildContext context) {
    FijkPanelWidgetBuilder builder;
    if (widget.type == WZPlayerType.match) {
      builder = matchPanelBuilder();
    } else if (widget.type == WZPlayerType.anchor) {
      builder = anchorPanelBuilder(
          title: widget.titleStr,
          callback: (data) {
            widget.callback!(data);
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
