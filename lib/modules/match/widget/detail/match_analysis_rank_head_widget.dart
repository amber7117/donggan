import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisRankHeadWidget extends StatefulWidget {
  const MatchAnalysisRankHeadWidget({super.key});

  @override
  State createState() => _MatchAnalysisRankHeadWidgetState();
}

class _MatchAnalysisRankHeadWidgetState
    extends State<MatchAnalysisRankHeadWidget> {
  @override
  Widget build(BuildContext context) {
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
                child: const Text(
                  "已赛",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 62.w,
                child: const Text(
                  "胜/平/负",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 62.w,
                child: const Text(
                  "进/失",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 62.w,
                child: const Text(
                  "积分",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
