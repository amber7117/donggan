import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusSegmentWidget extends StatefulWidget {
  final List<String> titleArr;
  final int selectIdx;

  const MatchStatusSegmentWidget({super.key, required this.titleArr, required this.selectIdx});

  @override
  State createState() => _MatchStatusSegmentWidgetState();
}

class _MatchStatusSegmentWidgetState extends State<MatchStatusSegmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14.0))
      ),
      child: Row(
        children: _buildChild(),
      ),
    );
  }

  _buildChild() {
    List<String> titleArr = widget.titleArr;
    List<Widget> children = [];
    for (int i = 0; i < titleArr.length; i++) {
      Widget child = Container(
        height: 24,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Text(titleArr[i],
            style: const TextStyle(
                color: ColorUtils.red233,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      );
      children.add(child);
    }
    return children;
  }

  
}