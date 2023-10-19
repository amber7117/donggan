import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const anchorCellRatio = 171 / 134;

class AnchorCellWidget extends StatefulWidget {
  final AnchorListModel model;

  const AnchorCellWidget({super.key, required this.model});

  @override
  State createState() => _AnchorCellWidgetState();
}

class _AnchorCellWidgetState extends State<AnchorCellWidget> {
  @override
  Widget build(BuildContext context) {
    double cellWidth = (ScreenUtil().screenWidth - 24 - 9) * 0.5;
    double coverHeight = cellWidth / 171 * 96;

    AnchorListModel model = widget.model;

    return InkWell(
      onTap: () {
        Routes.push(context, Routes.anchorDetail, arguments: model.anchorId);
      },
      child: Container(
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
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: buildNetImage(model.roomImg,
                    width: cellWidth,
                    height: coverHeight,
                    placeholder: "common/imgZhiboMoren")),
            Expanded(
                child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 6),
                    child: CircleImgPlaceWidget(
                        imgUrl: model.headImageUrl,
                        width: 18,
                        placeholder: "common/iconZhubo")),
                Expanded(
                    child: Text(model.nickName,
                        style: TextStyle(
                            color: ColorUtils.gray153,
                            fontSize: 10.sp,
                            fontWeight: TextStyleUtils.medium))),
                const JhAssetImage("anchor/iconFire", width: 14),
                Padding(
                    padding: const EdgeInsets.only(left: 2, right: 10),
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
      ),
    );
  }
}
