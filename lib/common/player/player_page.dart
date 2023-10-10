import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  final String urlStr;

  const PlayerPage({super.key, required this.urlStr});

  @override
  State createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
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
