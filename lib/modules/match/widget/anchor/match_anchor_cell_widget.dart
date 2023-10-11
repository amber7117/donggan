import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              width: 100.w,
              height: 80.w,
              placeholder: "common/imgZhiboMoren",
              fit: BoxFit.fitWidth),
          Row(
            children: [
              // JhAssetImage(model.headImageUrl, width: 18, height: 18),
              Text(model.nickName,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 10.sp,
                      fontWeight: TextStyleUtils.medium)),
              Text(AppBusinessUtils.obtainVideoHotDesc(model.anchorHot),
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 10.sp,
                      fontWeight: TextStyleUtils.medium))
            ],
          )
        ],
      ),
    );
  }
}
