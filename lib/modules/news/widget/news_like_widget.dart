import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class NewsLikeWidget extends StatelessWidget {
  final int likeCount;
  final bool isLike;
  const NewsLikeWidget({
    super.key,
    required this.likeCount,
    required this.isLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        likeCount > 0
            ? Text(
                "$likeCount",
                style: TextStyle(
                    color: isLike
                        ? ColorUtils.red233
                        : const Color.fromRGBO(217, 217, 217, 1.0),
                    fontSize: 12,
                    fontWeight: TextStyleUtils.regual),
              )
            : const SizedBox(),
        const SizedBox(width: 5),
        isLike
            ? const JhAssetImage("news/iconNewsLikeS", width: 16)
            : const JhAssetImage("news/iconNewsLike", width: 16)
      ],
    );
  }
}
