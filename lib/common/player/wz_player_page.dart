import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:wzty/common/player/custom_panel_anchor_widget.dart';
import 'package:wzty/common/player/custom_panel_match_widget.dart';
import 'package:wzty/common/player/custom_panel_playback_widget.dart';
import 'package:wzty/utils/jh_image_utils.dart';

enum WZPlayerType { match, anchor, playback }

class WZPlayerPage extends StatefulWidget {
  final String urlStr;

  final WZPlayerType type;

  const WZPlayerPage({super.key, required this.urlStr, required this.type});

  @override
  State createState() => _WZPlayerPageState();
}

class _WZPlayerPageState extends State<WZPlayerPage> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();

    player.setDataSource(widget.urlStr, autoPlay: true);
  }

  @override
  void dispose() {
    super.dispose();

    player.stop();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    FijkPanelWidgetBuilder builder;
    if (widget.type == WZPlayerType.match) {
      builder = matchPanelBuilder();
    } else if (widget.type == WZPlayerType.anchor) {
      builder = anchorPanelBuilder();
    } else {
      builder = playbackPanelBuilder();
    }
    
    return FijkView(
      player: player,
      panelBuilder: builder,
      fit: FijkFit.ar16_9,
      fsFit: FijkFit.ar16_9,
      cover: AssetImage(JhImageUtils.obtainImgPath("anchor/imgLiveBg", x2: false)),
    );
  }
}
