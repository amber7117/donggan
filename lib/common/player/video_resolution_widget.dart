import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class AnchorVideoResolutionWidget extends StatelessWidget {
  final String selectedTitle;
  final List<String> dataArr;
  final Map<String, String> playUrlDic;
  final bool isFullScreen;
  final WZAnyCallback callback;

  const AnchorVideoResolutionWidget(
      {super.key,
      required this.selectedTitle,
      required this.dataArr,
      required this.playUrlDic,
      required this.isFullScreen,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Container(
          width: ScreenUtil().scaleWidth * 0.5,
          height: 200,
          color: Colors.black.withOpacity(0.6),
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 270,
            height: 66,
            child: GridView.builder(
                padding: const EdgeInsets.only(top: 10, left: 12, bottom: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataArr.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  childAspectRatio: 60 / 28,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      callback(index);
                    },
                    child: _buildCellWidget(index),
                  );
                }),
          )),
    );
  }

  _buildCellWidget(int index) {
    String title = dataArr[index];
    return Container(
        child: Text(title,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 16,
                fontWeight: TextStyleUtils.regual)));
  }
}
