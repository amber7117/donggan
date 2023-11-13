import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class AnchorDetailHeadEmptyWidget extends StatelessWidget {
  final double height;

  const AnchorDetailHeadEmptyWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + ScreenUtil().statusBarHeight,
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: height,
                child: const JhAssetImage("anchor/imgLiveBg",
                    fit: BoxFit.cover, x2: false),
              ),
              const WZBackButton(),
            ],
          )
        ],
      ),
    );
  }
}
