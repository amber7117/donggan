import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisScheduleCellWidget extends StatefulWidget {
  final MatchAnalysisMatchModel model;

  const MatchAnalysisScheduleCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchAnalysisScheduleCellWidgetState();
}

class _MatchAnalysisScheduleCellWidgetState
    extends State<MatchAnalysisScheduleCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchAnalysisMatchModel model = widget.model;
    return Row(
      children: [
        SizedBox(width: 12.w),
        SizedBox(
          width: 64.w,
          child: Text(
            "${model.matchTimeNew}\n${model.leagueName}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        SizedBox(width: 28.w),
        SizedBox(
          width: 80.w,
          child: Text(
            model.hostTeamName,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.bold),
          ),
        ),
        SizedBox(
          width: 27.w,
          child: const Text(
            "VS",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:  TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.bold),
          ),
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            model.guestTeamName,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.bold),
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
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.bold),
          ),
        ),
      ],
    );
  }
}
