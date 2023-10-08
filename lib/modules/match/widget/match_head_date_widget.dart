import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchHeadDateWidget extends StatefulWidget {
  final List<String> dateArr;
  final int selectIdx;

  const MatchHeadDateWidget(
      {super.key, required this.dateArr, required this.selectIdx});

  @override
  State createState() => _MatchHeadDateWidgetState();
}

class _MatchHeadDateWidgetState extends State<MatchHeadDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10, left: 12, bottom: 10),
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.dateArr.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 6,
                    childAspectRatio: 52 / 33,
                  ),
                  itemBuilder: (context, index) {
                    return _buildCellWidget(index);
                  })),
          const Padding(
              padding: EdgeInsets.all(12),
              child: JhAssetImage("match/iconCalendar", width: 24)),
        ],
      ),
    );
  }

  _buildCellWidget(int index) {
    String dateStr = widget.dateArr[index];
    String dateStr2 = "";
    if (dateStr.contains("\n")) {
      List<String> ret = dateStr.split("\n");
      dateStr = ret.first;
      dateStr2 = ret.last;
    }
    if (widget.selectIdx == index) {
      return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 240, 242, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dateStr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtils.red233,
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.medium),
            ),
            dateStr2.isEmpty
                ? const SizedBox()
                : Text(
                    dateStr2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorUtils.red233,
                        fontSize: 8.sp,
                        fontWeight: TextStyleUtils.medium),
                  ),
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dateStr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color.fromRGBO(102, 102, 102, 1.0),
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.medium),
            ),
            dateStr2.isEmpty
                ? const SizedBox()
                : Text(
                    dateStr2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color.fromRGBO(179, 179, 179, 1.0),
                        fontSize: 8.sp,
                        fontWeight: TextStyleUtils.medium),
                  ),
          ],
        ),
      );
    }
  }
}
