import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:wzty/main/config/config_manager.dart';

class PlayerDanmuWidget extends StatefulWidget {
  const PlayerDanmuWidget({super.key});

  @override
  State createState() => _PlayerDanmuWidgetState();
}

class _PlayerDanmuWidgetState extends State<PlayerDanmuWidget> {
  final barrageWallController = BarrageWallController();

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    List<Bullet> bullets = List<Bullet>.generate(10, (i) {
      final showTime = random.nextInt(60000); // in 60s
      return Bullet(
          child: Text('$i-$showTime',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ConfigManager.instance.barrageFont.toDouble(),
                  fontWeight: FontWeight.w400)),
          showTime: showTime);
    });

    return ColoredBox(
      color: Colors.green,
      child: BarrageWall(
        debug: false,
        // safeBottomHeight: 60, // do not send bullets to the safe area
        // speed: 8,
        // speedCorrectionInMilliseconds: 3000,
        // timelineNotifier: timelineNotifier, // send a BarrageValue notifier let bullet fires using your own timeline*/
        bullets: bullets,
        controller: barrageWallController,
        child: const SizedBox(),
      ),
    );
  }
}
