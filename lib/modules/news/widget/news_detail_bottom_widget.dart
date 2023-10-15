import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class NewsDetailBottomWidget extends StatefulWidget {
  const NewsDetailBottomWidget({super.key});

  @override
  State createState() => _NewsDetailBottomWidgetState();
}

class _NewsDetailBottomWidgetState extends State<NewsDetailBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().bottomBarHeight + 56,
      child: Column(
        children: [
          const SizedBox(width: double.infinity, height: 0.5)
              .colored(ColorUtils.gray229),
          Row(children: [
            Container(
              width: 270.w,
              height: 36,
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 18),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(247, 247, 250, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: JhAssetImage("news/iconZixunHuabi", width: 20)),
                  Text(
                    "我也来说几句",
                    style: TextStyle(
                        color: ColorUtils.gray179,
                        fontSize: 14.sp,
                        fontWeight: TextStyleUtils.regual),
                  ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(10),
                child: JhAssetImage("news/iconNewsCollect", width: 16)),
            const Padding(
                padding: EdgeInsets.all(10),
                child: JhAssetImage("news/iconNewsShare", width: 16)),
          ]),
        ],
      ),
    );
  }
}
