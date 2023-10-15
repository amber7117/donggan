import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/clip_img_widget.dart';
import 'package:wzty/modules/news/entity/news_comment_entity.dart';
import 'package:wzty/modules/news/widget/news_like_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class NewsDetailCommentWidget extends StatefulWidget {
  final NewsCommentModel model;

  const NewsDetailCommentWidget({super.key, required this.model});

  @override
  State createState() => _NewsDetailCommentWidgetState();
}

class _NewsDetailCommentWidgetState extends State<NewsDetailCommentWidget> {
  @override
  Widget build(BuildContext context) {
    NewsCommentModel model = widget.model;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipImgWidget(
                  imgUrl: model.headImgUrl,
                  width: 40,
                  placeholder: "common/iconTouxiang"),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 299.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.nickName,
                          style: TextStyle(
                              color: const Color.fromRGBO(20, 102, 191, 1.0),
                              fontSize: 14.sp,
                              fontWeight: TextStyleUtils.regual),
                        ),
                        NewsLikeWidget(model: model),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 299.w,
                    child: Text(
                      model.content,
                      maxLines: null,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 16.sp,
                          fontWeight: TextStyleUtils.regual),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "2h之前",
                        style: TextStyle(
                            color: ColorUtils.gray153,
                            fontSize: 12.sp,
                            fontWeight: TextStyleUtils.regual),
                      ),
                      const SizedBox(width: 10),
                      model.sonNum > 0
                          ? Text(
                              "共${model.sonNum}条回复",
                              style: TextStyle(
                                  color: const Color.fromRGBO(58, 58, 60, 1.0),
                                  fontSize: 12.sp,
                                  fontWeight: TextStyleUtils.regual),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: double.infinity, height: 0.5)
            .colored(ColorUtils.gray229),
      ],
    );
  }
}
