import 'package:flutter/material.dart';

enum WZImagePosition { left, right, top, bottom }

class WZImageButton extends StatelessWidget {
  final String imagePath;
  final double imageSize;

  final String title;
  final TextStyle titleStyle;

  final WZImagePosition possiton;

  final double spacing;

  final VoidCallback callBack;

  const WZImageButton({
    super.key,

    // 图片路径  大小
    this.imagePath = "",
    this.imageSize = 16,

    // 字体
    this.title = "",
    required this.titleStyle,

    // 配置
    this.possiton = WZImagePosition.left,
    this.spacing = 5.0,

    // 回调
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          callBack();
        },
        child: (possiton == WZImagePosition.top ||
                possiton == WZImagePosition.bottom)
            ? _getTopAndBottomPosstionWidget(possiton == WZImagePosition.top)
            : _getLeftAndRightPosstionWidget(possiton == WZImagePosition.left));
  }

  Widget _getTopAndBottomPosstionWidget(bool isTop) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isTop
            ? [
                _getImage(),
                SizedBox(
                  height: spacing,
                ),
                _getTitle()
              ]
            : [
                _getTitle(),
                SizedBox(
                  height: spacing,
                ),
                _getImage()
              ]);
  }

  Widget _getLeftAndRightPosstionWidget(bool isLeft) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isLeft
            ? [_getImage(), SizedBox(width: spacing), _getTitle()]
            : [_getTitle(), SizedBox(width: spacing), _getImage()]);
  }

  Widget _getImage() {
    return Image.asset(
      imagePath,
      width: imageSize,
      height: imageSize,
    );
  }

  Widget _getTitle() {
    return Text(title, style: titleStyle);
  }
}
