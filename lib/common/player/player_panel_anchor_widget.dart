import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/player/player_panel_utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

FijkPanelWidgetBuilder anchorPanelBuilder(
    {Key? key,
    bool fill = false,
    int animTime = 5000,
    bool doubleTap = true,
    final String? title,
    required WZAnyCallback<PlayPanelEvent> callback,
    VoidCallback? onBack}) {
  return (FijkPlayer player, FijkData data, BuildContext context, Size viewSize,
      Rect texturePos) {
    return _PlayerPanelAnchor(
      key: key,
      player: player,
      data: data,
      viewSize: viewSize,
      texPos: texturePos,
      fill: fill,
      doubleTap: doubleTap,
      hideDuration: animTime,
      title: title,
      callback: callback,
      onBack: onBack,
    );
  };
}

class _PlayerPanelAnchor extends StatefulWidget {
  final FijkPlayer player;
  final FijkData data;
  final Size viewSize;
  final Rect texPos;
  final bool fill;
  final bool doubleTap;
  final int hideDuration;

  final String? title;
  final WZAnyCallback<PlayPanelEvent> callback;
  final VoidCallback? onBack;

  const _PlayerPanelAnchor({
    super.key,
    required this.player,
    required this.data,
    required this.viewSize,
    required this.texPos,
    required this.fill,
    required this.doubleTap,
    required this.hideDuration,
    this.title,
    required this.callback,
    this.onBack,
  });

  @override
  State createState() => __PlayerPanelAnchorState();
}

class __PlayerPanelAnchorState extends State<_PlayerPanelAnchor> {
  FijkPlayer get player => widget.player;

  Timer? _hideTimer;
  bool _hideStuff = true;

  Timer? _statelessTimer;
  bool _prepared = false;
  bool _playing = false;
  bool _dragLeft = false;
  double? _volume;
  double? _brightness;

  late StreamController<double> _valController;

  @override
  void initState() {
    super.initState();

    _valController = StreamController.broadcast();
    _prepared = player.state.index >= FijkState.prepared.index;
    _playing = player.state == FijkState.started;

    player.addListener(_playerValueChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _valController.close();
    _hideTimer?.cancel();
    _statelessTimer?.cancel();
    player.removeListener(_playerValueChanged);
  }

  double dura2double(Duration d) {
    return d.inMilliseconds.toDouble();
  }

  void _playerValueChanged() {
    FijkValue value = player.value;

    bool playing = (value.state == FijkState.started);
    bool prepared = value.prepared;
    if (playing != _playing ||
        prepared != _prepared ||
        value.state == FijkState.asyncPreparing) {
      setState(() {
        _playing = playing;
        _prepared = prepared;
      });
    }
  }

  void _restartHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(Duration(milliseconds: widget.hideDuration), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  // MARK: - Method

  void onTapFun() {
    if (_hideStuff == true) {
      _restartHideTimer();
    }
    setState(() {
      _hideStuff = !_hideStuff;
    });
  }

  void playOrPause() {
    if (player.isPlayable() || player.state == FijkState.asyncPreparing) {
      if (player.state == FijkState.started) {
        player.pause();
      } else {
        player.start();
      }
    } else if (player.state == FijkState.initialized) {
      player.start();
    } else {
      FijkLog.w("Invalid state ${player.state} ,can't perform play or pause");
    }
  }

  void onDoubleTapFun() {
    playOrPause();
  }

  void onVerticalDragStartFun(DragStartDetails d) {
    if (d.localPosition.dx > panelWidth() / 2) {
      // right, volume
      _dragLeft = false;
      FijkVolume.getVol().then((v) {
        if (!widget.data.contains(WZFijkData.fijkViewPanelVolume)) {
          widget.data.setValue(WZFijkData.fijkViewPanelVolume, v);
        }
        setState(() {
          _volume = v;
          _valController.add(v);
        });
      });
    } else {
      // left, brightness
      _dragLeft = true;
      FijkPlugin.screenBrightness().then((v) {
        if (!widget.data.contains(WZFijkData.fijkViewPanelBrightness)) {
          widget.data.setValue(WZFijkData.fijkViewPanelBrightness, v);
        }
        setState(() {
          _brightness = v;
          _valController.add(v);
        });
      });
    }
    _statelessTimer?.cancel();
    _statelessTimer = Timer(const Duration(milliseconds: 2000), () {
      setState(() {});
    });
  }

  void onVerticalDragUpdateFun(DragUpdateDetails d) {
    double delta = d.primaryDelta! / panelHeight();
    delta = -delta.clamp(-1.0, 1.0);
    if (_dragLeft == false) {
      var volume = _volume;
      if (volume != null) {
        volume += delta;
        volume = volume.clamp(0.0, 1.0);
        _volume = volume;
        FijkVolume.setVol(volume);
        setState(() {
          _valController.add(volume!);
        });
      }
    } else if (_dragLeft == true) {
      var brightness = _brightness;
      if (brightness != null) {
        brightness += delta;
        brightness = brightness.clamp(0.0, 1.0);
        _brightness = brightness;
        FijkPlugin.setScreenBrightness(brightness);
        setState(() {
          _valController.add(brightness!);
        });
      }
    }
  }

  void onVerticalDragEndFun(DragEndDetails e) {
    _volume = null;
    _brightness = null;
  }

  // MARK: - UI & Property

  /// 返回按钮
  Widget buildBackButtom(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(left: 5),
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Color(0xDDFFFFFF),
      ),
      onPressed: widget.onBack,
    );
  }

  /// 刷新按钮
  Widget buildRefreshButton(BuildContext context) {
    return InkWell(
        onTap: () async {
          await player.reset();
          player.setDataSource(player.dataSource!, autoPlay: true);
        },
        child: const Padding(
            padding: EdgeInsets.all(10),
            child: JhAssetImage("anchor/iconRefresh", width: 24)));
  }

  /// 弹幕按钮
  Widget buildDanmuButton(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: const Padding(
            padding: EdgeInsets.all(10),
            child: JhAssetImage("anchor/iconDanmu", width: 24)));
  }

  /// 弹幕设置按钮
  Widget buildDanmuSetButton(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: const Padding(
            padding: EdgeInsets.all(10),
            child: JhAssetImage("anchor/iconDanmuS", width: 24)));
  }

  /// 弹幕全屏按钮
  Widget buildFullScreenButton(BuildContext context) {
    String imgPath;
    if (player.value.fullScreen) {
      imgPath = "anchor/iconQuanPing2";
    } else {
      imgPath = "anchor/iconQuanPing";
    }
    return InkWell(
        onTap: () {
          player.value.fullScreen
              ? player.exitFullScreen()
              : player.enterFullScreen();
        },
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: JhAssetImage(imgPath, width: 24)));
  }

  /// 底部菜单栏
  Widget buildBottom(BuildContext context, double height) {
    return Row(
      children: <Widget>[
        buildRefreshButton(context),
        const Spacer(),
        buildDanmuButton(context),
        buildDanmuSetButton(context),
        buildFullScreenButton(context),
      ],
    );
  }

  /// 分辨率按钮
  Widget buildResolutionButton(BuildContext context) {
    return Container(
      width: 40,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text("标清",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: TextStyleUtils.regual)),
    );
  }

  /// 更多按钮
  Widget buildMoreButton(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.callback(PlayPanelEvent.more);
        },
        child: const Padding(
            padding: EdgeInsets.all(10),
            child: JhAssetImage("anchor/iconGengduo", width: 24)));
  }

  /// 顶部菜单栏
  Widget buildTop(BuildContext context, double height) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 44),
        Expanded(
          child: Text(widget.title ?? "",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: TextStyleUtils.regual)),
        ),
        const SizedBox(width: 20),
        buildResolutionButton(context),
        player.value.fullScreen ? const SizedBox() : buildMoreButton(context),
      ],
    );
  }

  /// 面板UI
  Widget buildPanel(BuildContext context) {
    double height = panelHeight();
    double toolHeight = height > 80 ? 80 : height / 5;
    double toolItemHeight = height > 80 ? 45 : height / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: toolHeight,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x88000000), Color(0x00000000)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: buildTop(context, toolItemHeight),
        ),
        const Spacer(),
        Container(
          height: toolHeight,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x88000000), Color(0x00000000)],
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
              ),
              color: Colors.green),
          child: buildBottom(context, toolItemHeight),
        )
      ],
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: onTapFun,
      onDoubleTap: widget.doubleTap ? onDoubleTapFun : null,
      onVerticalDragUpdate: onVerticalDragUpdateFun,
      onVerticalDragStart: onVerticalDragStartFun,
      onVerticalDragEnd: onVerticalDragEndFun,
      onHorizontalDragUpdate: (d) {},
      child: AbsorbPointer(
        absorbing: _hideStuff,
        child: AnimatedOpacity(
          opacity: _hideStuff ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: buildPanel(context),
        ),
      ),
    );
  }

  Widget buildStateless() {
    var volume = _volume;
    var brightness = _brightness;
    if (volume != null || brightness != null) {
      Widget toast = volume == null
          ? defaultFijkBrightnessToast(brightness!, _valController.stream)
          : defaultFijkVolumeToast(volume, _valController.stream);
      return IgnorePointer(
        child: AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 500),
          child: toast,
        ),
      );
    } else if (player.state == FijkState.asyncPreparing) {
      return Container(
        alignment: Alignment.center,
        child: const SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorUtils.red233)),
        ),
      );
    } else if (player.state == FijkState.error) {
      return Container(
        alignment: Alignment.center,
        child: const Icon(
          Icons.error,
          size: 30,
          color: ColorUtils.red233,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = panelRect();

    List ws = <Widget>[];

    if (_statelessTimer != null && _statelessTimer!.isActive) {
      ws.add(buildStateless());
    } else if (player.state == FijkState.asyncPreparing) {
      ws.add(buildStateless());
    } else if (player.state == FijkState.error) {
      ws.add(buildStateless());
    }
    ws.add(buildGestureDetector(context));
    if (widget.onBack != null) {
      ws.add(buildBackButtom(context));
    }
    return Positioned.fromRect(
      rect: rect,
      child: Stack(children: ws as List<Widget>),
    );
  }

  // MARK: - Utils

  Rect panelRect() {
    Rect rect = player.value.fullScreen || (true == widget.fill)
        ? Rect.fromLTWH(0, 0, widget.viewSize.width, widget.viewSize.height)
        : Rect.fromLTRB(
            max(0.0, widget.texPos.left),
            max(0.0, widget.texPos.top),
            min(widget.viewSize.width, widget.texPos.right),
            min(widget.viewSize.height, widget.texPos.bottom));
    return rect;
  }

  double panelHeight() {
    if (player.value.fullScreen || (true == widget.fill)) {
      return widget.viewSize.height;
    } else {
      return min(widget.viewSize.height, widget.texPos.bottom) -
          max(0.0, widget.texPos.top);
    }
  }

  double panelWidth() {
    if (player.value.fullScreen || (true == widget.fill)) {
      return widget.viewSize.width;
    } else {
      return min(widget.viewSize.width, widget.texPos.right) -
          max(0.0, widget.texPos.left);
    }
  }
}
