import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisSegmentWidget extends StatefulWidget {
  final WZAnyCallback<int> callback;

  const MatchAnalysisSegmentWidget({super.key, required this.callback});

  @override
  State createState() => _MatchAnalysisSegmentWidgetState();
}

class _MatchAnalysisSegmentWidgetState
    extends State<MatchAnalysisSegmentWidget> {
  final List<String> titleArr = ["同赛事", "同主客"];
  int selectIdx = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 106,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildChild(50),
      ),
    );
  }

  _buildChild(double itemWidth) {
    List<Widget> children = [];
    for (int i = 0; i < titleArr.length; i++) {
      bool select = selectIdx == i;
      Widget child = InkWell(
        onTap: () {
          if (selectIdx == i) {
            selectIdx = -1;
          } else {
            selectIdx = i;
          }

          setState(() {});

          widget.callback(selectIdx);
        },
        child: Container(
          width: itemWidth,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: select
                  ? ColorUtils.red233
                  : const Color.fromRGBO(250, 250, 250, 1),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Text(titleArr[i],
              style: TextStyle(
                  color: select ? Colors.white : ColorUtils.gray153,
                  fontSize: 10,
                  fontWeight: TextStyleUtils.regual)),
        ),
      );
      children.add(child);
    }
    return children;
  }
}
