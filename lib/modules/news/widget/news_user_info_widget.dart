import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/clip_img_widget.dart';
import 'package:wzty/common/widget/wz_follow_button.dart';
import 'package:wzty/modules/news/entity/news_detail_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class NewsUserInfoWidget extends StatefulWidget {
  final NewsDetilInfoModel model;

  const NewsUserInfoWidget({super.key, required this.model});

  @override
  State createState() => _NewsUserInfoWidgetState();
}

class _NewsUserInfoWidgetState extends State<NewsUserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    NewsDetilInfoModel model = widget.model;
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ClipImgWidget(
                imgUrl: model.headImgUrl,
                width: 40,
                placeholder: "common/iconTouxiang")),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.nickName,
                style: TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 14.sp,
                    fontWeight: TextStyleUtils.semibold),
              ),
              Text(
                model.createdDate,
                style: TextStyle(
                    color: const Color.fromRGBO(102, 102, 102, 1.0),
                    fontSize: 12.sp,
                    fontWeight: TextStyleUtils.regual),
              ),
            ],
          ),
        ),
        WZFollowBtn(followed: model.isAttention)
      ],
    );
  }
}
