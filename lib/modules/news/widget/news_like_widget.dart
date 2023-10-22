import 'package:flutter/material.dart';
import 'package:wzty/modules/news/entity/news_comment_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class NewsLikeWidget extends StatefulWidget {
  final NewsCommentModel model;

  const NewsLikeWidget({super.key, required this.model});

  @override
  State createState() => _NewsLikeWidgetState();
}

class _NewsLikeWidgetState extends State<NewsLikeWidget> {
  @override
  Widget build(BuildContext context) {
    NewsCommentModel model = widget.model;

    return InkWell(
      onTap: () {
        
      },
      child: Row(
        children: [
          model.likeCount > 0
              ? Text(
                  "${model.likeCount}",
                  style: TextStyle(
                      color: model.isLike
                          ? const Color.fromRGBO(217, 217, 217, 1.0)
                          : ColorUtils.red233,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual),
                )
              : const SizedBox(),
          model.isLike
              ? const JhAssetImage("news/iconNewsLikeS", width: 16)
              : const JhAssetImage("news/iconNewsLike", width: 16)
        ],
      ),
    );
  }
}
