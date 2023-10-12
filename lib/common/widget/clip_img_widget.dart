import 'package:flutter/widgets.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class ClipImgWidget extends StatefulWidget {
  final String imgUrl;
  final double width;

  final BoxFit boxFit;
  final String? placeholder;

  const ClipImgWidget(
      {super.key,
      required this.imgUrl,
      required this.width,
      this.boxFit = BoxFit.cover,
      this.placeholder});

  @override
  State createState() => _ClipImgWidgetState();
}

class _ClipImgWidgetState extends State<ClipImgWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: SizedBox(
            width: widget.width,
            height: widget.width,
            child: buildNetImage(widget.imgUrl,
                width: widget.width, placeholder: widget.placeholder)));
  }
}
