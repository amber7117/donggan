import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisRankHeadWidget extends StatefulWidget {
  final SportType sportType;

  const MatchAnalysisRankHeadWidget({super.key, required this.sportType});

  @override
  State createState() => _MatchAnalysisRankHeadWidgetState();
}

class _MatchAnalysisRankHeadWidgetState
    extends State<MatchAnalysisRankHeadWidget> {
  @override
  Widget build(BuildContext context) {
    String text1;
    String text2;
    String text3;
    String text4;
    if (widget.sportType == SportType.football) {
      text1 = "已赛";
      text2 = "胜/平/负";
      text3 = "进/失";
      text4 = "积分";
    } else {
      text1 = "胜-负";
      text2 = "均得分";
      text3 = "均失分";
      text4 = "状态";
    }

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              const SizedBox(width: 12),
              const SizedBox(width: 3, height: 12).decorate(const BoxDecoration(
                  color: ColorUtils.red233,
                  borderRadius: BorderRadius.all(Radius.circular(1.5)))),
              const SizedBox(width: 5),
              const Text(
                "赛前排名",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 11,
                    fontWeight: TextStyleUtils.regual),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          color: ColorUtils.gray248,
          child: Row(
            children: [
              SizedBox(
                width: 46.w,
                child: const Text(
                  "球队",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 81.w,
                child: const Text(
                  "排名",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 62.w,
                child: Text(
                  text1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 62.w,
                child: Text(
                  text2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 62.w,
                child: Text(
                  text3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 62.w,
                child: Text(
                  text4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
