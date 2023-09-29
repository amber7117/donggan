import 'package:flutter/material.dart';

enum JCImagePossition { left, right, top, bottom }

class JCImageButton extends StatelessWidget {
  final String imageAssets;
  final String titleString;
  final Color bgColor;
  final double imageSize;
  final double cornerRadius;
  final double interval;
  final Color titleColor;
  final double titleSize;
  final FontWeight fontweight;
  final JCImagePossition possiton;

  late final VoidCallback callBack;
  late final EdgeInsetsGeometry padding;

  JCImageButton({
    super.key,
    // 背景颜色  圆角
    this.bgColor = Colors.blue,
    this.cornerRadius = 2,

    // 图片路劲  大小
    this.imageAssets = "",
    this.imageSize = 16,

    // 字体
    this.titleString = "",
    this.titleColor = Colors.white,
    this.titleSize = 16,
    this.fontweight = FontWeight.w400,

    // 文字和图片间隔、 padding
    this.interval = 8,
    EdgeInsetsGeometry? padding,

    // 位置 回调
    this.possiton = JCImagePossition.left,
    VoidCallback? callBack, // 回调
  }) {
    this.padding = padding ?? EdgeInsets.zero;
    this.callBack = callBack ?? () {};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        color: bgColor,
      ),
      child: TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
          onPressed: () {
            callBack();
          },
          child: (possiton == JCImagePossition.top ||
                  possiton == JCImagePossition.bottom)
              ? _getTopAndBottomPosstionWidget(possiton == JCImagePossition.top)
              : _getLeftAndRightPosstionWidget(
                  possiton == JCImagePossition.left)),
    );
  }

  Widget _getTopAndBottomPosstionWidget(bool isTop) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isTop
            ? [
                _getImage(),
                Container(
                  height: interval,
                ),
                _getTitle()
              ]
            : [
                _getTitle(),
                Container(
                  height: interval,
                ),
                _getImage()
              ]);
  }

  Widget _getLeftAndRightPosstionWidget(bool isLeft) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isLeft
            ? [_getImage(), SizedBox(width: interval), _getTitle()]
            : [_getTitle(), SizedBox(width: interval), _getImage()]);
  }

  Widget _getImage() {
    return Image.asset(
      imageAssets,
      width: imageSize,
      height: imageSize,
    );
  }

  Widget _getTitle() {
    return Text(
      titleString,
      style: TextStyle(
          color: titleColor, fontSize: titleSize, fontWeight: fontweight),
    );
  }
}
