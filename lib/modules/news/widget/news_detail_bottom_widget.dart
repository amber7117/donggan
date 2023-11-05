import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/modules/news/entity/news_detail_entity.dart';
import 'package:wzty/modules/news/service/news_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

const newsDetailBottomHeight = 56.0;

class NewsDetailBottomWidget extends StatefulWidget {
  final NewsDetailInfoModel model;

  final VoidCallback commentCb;

  const NewsDetailBottomWidget({super.key, required this.model, required this.commentCb});

  @override
  State createState() => _NewsDetailBottomWidgetState();
}

class _NewsDetailBottomWidgetState extends State<NewsDetailBottomWidget> {
  _requestNewsCollect() async {
    NewsDetailInfoModel model = widget.model;

    bool isCollect = !model.isFavorites;

    ToastUtils.showLoading();

    NewsService.requestCollect(model.getNewsId(), isCollect, (success, result) {
      ToastUtils.hideLoading();
      if (result.isNotEmpty) {
        ToastUtils.showError(result);
      } else {
        ToastUtils.showSuccess(isCollect ? "收藏成功" : "取消收藏成功");
        model.isFavorites = isCollect;

        setState(() {});
      }
    });
  }

  _requestNewsLink() {
    NewsDetailInfoModel model = widget.model;

    if (model.isLike) return;

    ToastUtils.showLoading();

    NewsService.requestLike(model.getNewsId(), (success, result) {
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
    NewsDetailInfoModel model = widget.model;

    return Container(
      color: Colors.white,
      height: ScreenUtil().bottomBarHeight + newsDetailBottomHeight,
      child: Column(
        children: [
          const SizedBox(width: double.infinity, height: 0.5)
              .colored(ColorUtils.gray229),
          Row(children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  widget.commentCb();
                },
                child: Container(
                  height: 36,
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 18),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(247, 247, 250, 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: const Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: JhAssetImage("news/iconZixunHuabi", width: 20)),
                      Text(
                        "我也来说几句",
                        style: TextStyle(
                            color: ColorUtils.gray179,
                            fontSize: 14,
                            fontWeight: TextStyleUtils.regual),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: _requestNewsCollect,
              child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: JhAssetImage("news/iconNewsCollect", width: 20)),
            ),
            InkWell(
              onTap: _requestNewsLink,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: JhAssetImage(
                      model.isLike ? "news/iconNewsLikeS" : "news/iconNewsLike",
                      width: 20)),
            ),
            const SizedBox(width: 12),
          ]),
        ],
      ),
    );
  }
}
