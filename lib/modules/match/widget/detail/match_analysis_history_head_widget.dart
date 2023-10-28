import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisHistoryHeadWidget extends StatefulWidget {
  const MatchAnalysisHistoryHeadWidget({super.key});

  @override
  State createState() => _MatchAnalysisHistoryHeadWidgetState();
}

class _MatchAnalysisHistoryHeadWidgetState
    extends State<MatchAnalysisHistoryHeadWidget> {
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
                "历史交手",
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
              SizedBox(width: 12.w),
              SizedBox(
                width: 64.w,
                child: const Text(
                  "时间",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(width: 28.w),
              SizedBox(
                width: 80.w,
                child: const Text(
                  "主队",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 27.w,
                child: const Text(
                  "VS",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(
                width: 80.w,
                child: const Text(
                  "客队",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: 64.w,
                child: const Text(
                  "半场",
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
