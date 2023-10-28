import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisHistoryCellWidget extends StatefulWidget {
  final MatchAnalysisMatchModel model;

  const MatchAnalysisHistoryCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchAnalysisHistoryCellWidgetState();
}

class _MatchAnalysisHistoryCellWidgetState
    extends State<MatchAnalysisHistoryCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchAnalysisMatchModel model = widget.model;
    return Row(
      children: [
        SizedBox(width: 12.w),
        SizedBox(
          width: 64.w,
          child: Text(
            "${model.leagueName}${model.matchTimeNew}",
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
          child: Text(
            "${model.hostTeamScore}-${model.guestTeamScore}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
            "${model.hostTeamHalfScore}-${model.guestTeamHalfScore}",
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
