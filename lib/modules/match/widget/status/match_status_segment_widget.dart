import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusSegmentWidget extends StatelessWidget {
  final List<String> titleArr;
  final int selectIdx;

  final WZAnyCallback<int> callback;

  const MatchStatusSegmentWidget(
      {super.key,
      required this.titleArr,
      required this.selectIdx,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    if (titleArr.isEmpty) {
      return const SizedBox();
    }
    double itemWidth = (ScreenUtil().screenWidth - 40 - 4) / titleArr.length;
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          height: 28,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(250, 250, 250, 1),
              borderRadius: BorderRadius.all(Radius.circular(14.0))),
          child: Row(
            children: _buildChild(itemWidth),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  _buildChild(double itemWidth) {
    List<Widget> children = [];

    for (int i = 0; i < titleArr.length; i++) {
      bool select = selectIdx == i;
      Widget child = InkWell(
        onTap: () {
          callback(i);
        },
        child: Container(
          width: itemWidth,
          height: 24,
          alignment: Alignment.center,
          decoration: select
              ? const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)))
              : const BoxDecoration(),
          child: Text(titleArr[i],
              style: TextStyle(
                  color: select ? ColorUtils.red233 : ColorUtils.gray153,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual)),
        ),
      );
      children.add(child);
    }
    return children;
  }
}
