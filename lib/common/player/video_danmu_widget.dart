import 'dart:async';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';

class VideoDanmuWidget extends StatefulWidget {
  const VideoDanmuWidget({super.key});

  @override
  State createState() => _VideoDanmuWidgetState();
}

class _VideoDanmuWidgetState extends State<VideoDanmuWidget> {
  final barrageWallController = BarrageWallController();

  late StreamSubscription _eventSub;

  @override
  void initState() {
    super.initState();

    _eventSub = eventBusManager.on<ChatMsgEvent>((event) {
      if (mounted) {
        Bullet bullet = Bullet(
            child: Text(event.msg.content,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ConfigManager.instance.barrageFont.toDouble(),
                    fontWeight: FontWeight.w400)),
            showTime: (event.msg.barrageDelay * 1000).toInt());
        barrageWallController.send([bullet]);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    eventBusManager.off(_eventSub);
  }

  @override
  Widget build(BuildContext context) {
    // Random random = Random();
    // List<Bullet> bullets = List<Bullet>.generate(10, (i) {
    //   final showTime = random.nextInt(60000); // in 60s
    //   return Bullet(
    //       child: Text('$i-$showTime',
    //           style: TextStyle(
    //               color: Colors.white,
    //               fontSize: ConfigManager.instance.barrageFont.toDouble(),
    //               fontWeight: FontWeight.w400)),
    //       showTime: showTime);
    // });

    return BarrageWall(
      debug: false,
      // safeBottomHeight: 60, // do not send bullets to the safe area
      // speed: 8,
      // speedCorrectionInMilliseconds: 3000,
      // timelineNotifier: timelineNotifier, // send a BarrageValue notifier let bullet fires using your own timeline*/
      bullets: const [],
      controller: barrageWallController,
      child: const SizedBox(),
    );
  }
}
