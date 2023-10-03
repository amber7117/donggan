
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class LoadEmptyWidget extends StatelessWidget {
  final String hintText;
  final String imageAsset;
  final double? imageWidth;
  final double? imageHeight;

  const LoadEmptyWidget(
      {Key? key,
      this.hintText = '暂无数据',
      this.imageAsset = "common/iconLoadEmpty",
      this.imageWidth = 132,
      this.imageHeight = 132})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            JhAssetImage(imageAsset, width: imageWidth, height: imageHeight),
            Text(
              hintText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.regual),
            )
          ],
        ),
      ),
    );
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        alignment: Alignment.center,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              JhAssetImage(imageAsset, width: imageWidth, height: imageHeight),
              Container(
                child: Text(
                  hintText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              )
            ]));
  }
}
