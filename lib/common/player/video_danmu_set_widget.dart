import 'package:flutter/material.dart';
import 'package:wzty/common/player/wz_player_manager.dart';
import 'package:wzty/utils/color_utils.dart';

class VideoDanmuSetWidget extends StatefulWidget {
  final Rect playRect;
  final bool fullScreen;
  final VoidCallback callback;

  const VideoDanmuSetWidget(
      {super.key,
      required this.playRect,
      required this.fullScreen,
      required this.callback});

  @override
  State createState() => _VideoDanmuSetWidgetState();
}

class _VideoDanmuSetWidgetState extends State<VideoDanmuSetWidget> {
  double _sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    if (widget.fullScreen) {
      return _buildFullscreenUI();
    } else {
      return _buildNormalUI();
    }
  }

  _buildNormalUI() {
    String resolution = WZPlayerManager.instance.resolution;
    List<String> titleArr = WZPlayerManager.instance.titleArr;

    return InkWell(
      onTap: () {
        widget.callback();
      },
      child: Container(
        width: widget.playRect.width,
        height: widget.playRect.height,
        alignment: Alignment.center,
        color: Colors.black.withOpacity(0.6),
        child: Container(
            width: 285,
            height: 112, //24
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("字幕字号",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 10),
                _buildFontMenuUI(),
                const SizedBox(height: 10),
                const Text("弹幕透明度",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
                // const SizedBox(height: 10),
                _buildSldierUI(),
              ],
            )),
      ),
    );
  }

  _buildFullscreenUI() {
    String resolution = WZPlayerManager.instance.resolution;
    List<String> titleArr = WZPlayerManager.instance.titleArr;

    return InkWell(
      onTap: () {
        widget.callback();
      },
      child: SizedBox(
        width: widget.playRect.width,
        height: widget.playRect.height,
        child: Container(
            width: widget.playRect.width * 0.5,
            height: widget.playRect.height,
            color: Colors.black.withOpacity(0.6),
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.yellow,
              width: 270,
              height: 66,
              alignment: Alignment.center,
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: titleArr.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 60 / 28,
                  ),
                  itemBuilder: (context, index) {
                    String title = titleArr[index];
                    return _buildFontItemWidget(title, title == resolution);
                  }),
            )),
      ),
    );
  }

  Widget _buildFontMenuUI() {
    return Row(
      children: [
        _buildFontItemWidget("14", false),
        const SizedBox(width: 10),
        _buildFontItemWidget("16", true),
        const SizedBox(width: 10),
        _buildFontItemWidget("18", false),
      ],
    );
  }

  _buildFontItemWidget(String title, bool selected) {
    return InkWell(
      onTap: () {
        widget.callback();
      },
      child: Container(
          width: 86,
          height: 30,
          alignment: Alignment.center,
          decoration: selected
              ? const BoxDecoration(
                  color: ColorUtils.red233,
                  borderRadius: BorderRadius.all(Radius.circular(14)))
              : BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(14))),
          child: Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400))),
    );
  }

  _buildSldierUI() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          trackHeight: 6, // 轨道高度
          trackShape: FullWidthTrackShape(), // 轨道形状，可以自定义
          activeTrackColor: ColorUtils.red233, // 激活的轨道颜色
          inactiveTrackColor: Colors.white.withOpacity(0.5), // 未激活的轨道颜色
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12 // 滑块大小
              ),
          thumbColor: Colors.white, // 滑块颜色
          overlayShape: const RoundSliderOverlayShape(
            overlayRadius: 14, // 滑块外圈大小
          ),
          overlayColor: ColorUtils.red233, // 滑块外圈颜色标签形状，可以自定义
          activeTickMarkColor: Colors.transparent, // 激活的刻度颜色
          inactiveTickMarkColor: Colors.transparent),
      child: Slider(
        value: _sliderValue,
        min: 0,
        max: 100,
        divisions: 10,
        onChanged: (v) {
          setState(() {
            _sliderValue = v;
          });
        },
      ),
    );
  }
}

class FullWidthTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 6.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    // 让轨道宽度等于 Slider 宽度
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
