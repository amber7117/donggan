import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/clip_img_widget.dart';
import 'package:wzty/modules/anchor/entity/live_list_entity.dart';
import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnchorCellWidget extends StatefulWidget {
  final LiveListModel model;

  const MatchAnchorCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchAnchorCellWidgetState();
}

class _MatchAnchorCellWidgetState extends State<MatchAnchorCellWidget> {
  @override
  Widget build(BuildContext context) {
    double cellWidth = (ScreenUtil().screenWidth - 24 - 9) * 0.5;
    LiveListModel model = widget.model;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(180, 180, 180, 0.2), // 阴影颜色
              spreadRadius: 0, // 阴影扩散程度
              blurRadius: 6, // 阴影模糊程度
              offset: Offset(0, 2), // 阴影偏移量
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          buildNetImage(model.roomImg,
              width: cellWidth,
              height: cellWidth / 171 * 96,
              placeholder: "common/imgZhiboMoren"),
          Expanded(
              child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 6),
                  child: ClipImgWidget(
                      imgUrl: model.headImageUrl,
                      width: 18,
                      placeholder: "common/iconZhubo")),
              Expanded(
                  child: Text(model.nickName,
                      style: TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 10.sp,
                          fontWeight: TextStyleUtils.medium))),
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                      AppBusinessUtils.obtainVideoHotDesc(model.anchorHot),
                      style: TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 10.sp,
                          fontWeight: TextStyleUtils.medium))),
            ],
          )),
        ],
      ),
    );
  }
}
