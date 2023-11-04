import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class EmojiContentWidget extends StatelessWidget {
  final List<String> dataArr;
  final WZAnyCallback callback;

  const EmojiContentWidget(
      {super.key, required this.dataArr, required this.callback});

  @override
  Widget build(BuildContext context) {
    double itemWidth = (ScreenUtil().screenWidth / 10);
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        childAspectRatio: 1.0,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      itemCount: dataArr.length,
      itemBuilder: (BuildContext context, int index) {
        String emojiStr = dataArr[index];
        if (emojiStr == "iconDelete") {
          return JhAssetImage("anchor/iconDelete", width: itemWidth);
        } else {
          return Align(
            alignment: Alignment.center,
            child: Text(emojiStr,
                style: const TextStyle(
                    color: ColorUtils.black51,
                    fontSize: 22,
                    fontWeight: TextStyleUtils.regual)),
          );
        }
      },
    );
  }
}
