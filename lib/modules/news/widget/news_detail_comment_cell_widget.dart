import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/modules/news/entity/news_comment_entity.dart';
import 'package:wzty/modules/news/service/news_service.dart';
import 'package:wzty/modules/news/widget/news_like_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class NewsDetailCommentCellWidget extends StatefulWidget {
  final NewsCommentModel model;

  const NewsDetailCommentCellWidget({super.key, required this.model});

  @override
  State createState() => _NewsDetailCommentCellWidgetState();
}

class _NewsDetailCommentCellWidgetState
    extends State<NewsDetailCommentCellWidget> {
  _requestCommentLike() async {
    NewsCommentModel model = widget.model;

    if (model.isLike) return;

    ToastUtils.showLoading();

    NewsService.requestCommentLike(model.id.toString(), (success, result) {
      ToastUtils.hideLoading();
      if (result.isNotEmpty) {
        ToastUtils.showError(result);
      } else {
        ToastUtils.showSuccess("点赞成功");
        model.isLike = true;
        model.likeCount++;

        setState(() {});
      }
    });
  }

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
              CircleImgPlaceWidget(
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
                          style: const TextStyle(
                              color: Color.fromRGBO(20, 102, 191, 1.0),
                              fontSize: 14,
                              fontWeight: TextStyleUtils.regual),
                        ),
                        InkWell(
                          onTap: () {
                            _requestCommentLike();
                          },
                          child: NewsLikeWidget(
                              likeCount: model.likeCount, isLike: model.isLike),
                        ),
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
                      style: const TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 16,
                          fontWeight: TextStyleUtils.regual),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                       Text(
                        model.createdDateNew,
                        style: const TextStyle(
                            color: ColorUtils.gray153,
                            fontSize: 12,
                            fontWeight: TextStyleUtils.regual),
                      ),
                      const SizedBox(width: 10),
                      model.sonNum > 0
                          ? Text(
                              "共${model.sonNum}条回复",
                              style: const TextStyle(
                                  color: Color.fromRGBO(58, 58, 60, 1.0),
                                  fontSize: 12,
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
