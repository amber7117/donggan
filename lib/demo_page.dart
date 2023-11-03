import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: "王者体育",
          debugShowCheckedModeBanner: false,
          home: VideoScreen(
              url:
                  'https://pull-new.52bch.com/live/6079249_lsd.flv?auth_info=Gav%2FVgjo3iXjoWbKlS9rTJqN4wJ%2BpVZ80gjJbgeRUJLYxvzWHp1XS8WgDJ2Zzejq.7975707371766768366f7a626976627a'),
        );
      },
    );
  }
}

class VideoScreen extends StatefulWidget {
  final String url;

  const VideoScreen({super.key, required this.url});

  @override
  State createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  _VideoScreenState();

  @override
  void initState() {
    super.initState();
    player.setDataSource(widget.url, autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fijkplayer Example")),
        body: Container(
          alignment: Alignment.center,
          child: FijkView(
            player: player,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
