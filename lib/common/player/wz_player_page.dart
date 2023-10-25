import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class WZPlayerPage extends StatefulWidget {
  final String urlStr;

  const WZPlayerPage({super.key, required this.urlStr});

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
    
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    return FijkView(
      player: player,
    );
  }
}
