import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisHistoryCellWidget extends StatefulWidget {
  final MatchAnalysisMatchModel model;
  final SportType sportType;

  const MatchAnalysisHistoryCellWidget(
      {super.key, required this.model, required this.sportType});

  @override
  State createState() => _MatchAnalysisHistoryCellWidgetState();
}

class _MatchAnalysisHistoryCellWidgetState
    extends State<MatchAnalysisHistoryCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchAnalysisMatchModel model = widget.model;

    double vsWidth = 44.0.w;
    double vsPadding = 11.0.w;
    if (widget.sportType == SportType.basketball) {
      vsWidth = 54.0.w;
      vsPadding = 1.0.w;
    }

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
        SizedBox(width: vsPadding),
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
          width: vsWidth,
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
