import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisRankCellWidget extends StatefulWidget {
  final MatchAnalysisRankTeamModel model;

  const MatchAnalysisRankCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchAnalysisRankCellWidgetState();
}

class _MatchAnalysisRankCellWidgetState
    extends State<MatchAnalysisRankCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchAnalysisRankTeamModel model = widget.model;
    return Row(
      children: [
        SizedBox(width: 13.w),
        buildNetImage(model.logo, width: 20, placeholder: "common/logoQiudui"),
        SizedBox(width: 13.w),
        SizedBox(
          width: 81.w,
          child: Text(
            "${model.leagueName}${model.teamRank}",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        SizedBox(
          width: 62.w,
          child: Text(
            "${model.matchCount}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.bold),
          ),
        ),
        SizedBox(
          width: 62.w,
          child: Text(
            "${model.win}/${model.draw}/${model.lost}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.bold),
          ),
        ),
        SizedBox(
          width: 62.w,
          child: Text(
            "${model.goal}/${model.lostGoal}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.bold),
          ),
        ),
        SizedBox(
          width: 62.w,
          child: Text(
            "${model.point}",
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
