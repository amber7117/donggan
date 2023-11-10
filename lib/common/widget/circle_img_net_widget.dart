import 'package:flutter/material.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class CirclImgNetWidget extends StatelessWidget {
  final String imgUrl;
  final double width;

  final BoxFit boxFit;

  const CirclImgNetWidget(
      {super.key,
      required this.imgUrl,
      required this.width,
      this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: width,
        child: CircleAvatar(backgroundImage: JhImageUtils.getNetImage(imgUrl)));
  }
}
