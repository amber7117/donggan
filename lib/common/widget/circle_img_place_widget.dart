import 'package:flutter/widgets.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class CircleImgPlaceWidget extends StatelessWidget {
  final String imgUrl;
  final double width;

  final BoxFit boxFit;
  final String? placeholder;

  const CircleImgPlaceWidget(
      {super.key,
      required this.imgUrl,
      required this.width,
      this.boxFit = BoxFit.cover,
      this.placeholder});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: SizedBox(
            width: width,
            height: width,
            child:
                buildNetImage(imgUrl, width: width, placeholder: placeholder)));
  }
}
