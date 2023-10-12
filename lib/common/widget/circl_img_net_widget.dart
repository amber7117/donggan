import 'package:flutter/material.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class CirclImgNetWidget extends StatefulWidget {
  final String imgUrl;
  final double width;

  final BoxFit boxFit;

  const CirclImgNetWidget(
      {super.key,
      required this.imgUrl,
      required this.width,
      this.boxFit = BoxFit.cover});

  @override
  State createState() => _CirclImgNetWidgetState();
}

class _CirclImgNetWidgetState extends State<CirclImgNetWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.width,
        child: CircleAvatar(
            backgroundImage: JhImageUtils.getNetImage(widget.imgUrl)));
  }
}
