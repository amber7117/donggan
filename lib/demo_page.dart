import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/player/custom_panel_playback_widget.dart';

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
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
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
            // panelBuilder: fijkPanel2Builder(),
            panelBuilder: playbackPanelBuilder(),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
