import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisScheduleCellWidget extends StatefulWidget {
  final MatchAnalysisMatchModel model;
  final String mainTeamName;

  const MatchAnalysisScheduleCellWidget(
      {super.key, required this.model, required this.mainTeamName});

  @override
  State createState() => _MatchAnalysisScheduleCellWidgetState();
}

class _MatchAnalysisScheduleCellWidgetState
    extends State<MatchAnalysisScheduleCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchAnalysisMatchModel model = widget.model;

    Color text1Color = ColorUtils.black34;
    Color text2Color = ColorUtils.black34;
    if (model.hostTeamName == widget.mainTeamName) {
      text2Color = ColorUtils.gray153;
    } else {
      text1Color = ColorUtils.gray153;
    }

    return Row(
      children: [
        SizedBox(width: 10.w),
        SizedBox(
          width: 64.w,
          child: Text(
            "${model.matchTimeNew}\n${model.leagueName}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorUtils.gray179,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        SizedBox(width: 11.w),
        SizedBox(
          width: 80.w,
          child: Text(
            model.hostTeamName,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: text1Color,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        SizedBox(
          width: 44.w,
          child: const Text(
            "VS",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.gray153,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            model.guestTeamName,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: text2Color,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        SizedBox(width: 20.w),
        SizedBox(
          width: 64.w,
          child: Text(
            "${model.timeInterval}天后",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorUtils.gray153,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
      ],
    );
  }
}
