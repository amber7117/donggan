import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisRankCellWidget extends StatelessWidget {
  final MatchAnalysisRankTeamModel model;
  final SportType sportType;

  const MatchAnalysisRankCellWidget(
      {super.key, required this.model, required this.sportType});

  @override
  Widget build(BuildContext context) {
    String text1;
    String text2;
    String text3;
    String text4;
    if (sportType == SportType.football) {
      text1 = "${model.matchCount}";
      text2 = "${model.win}/${model.draw}/${model.lost}";
      text3 = "${model.goal}/${model.lostGoal}";
      text4 = "${model.point}";
    } else {
      text1 = "${model.win}-${model.lost}";
      text2 = "${model.points}";
      text3 = "${model.lostPoints}";
      text4 = "${model.continuousStatus}连胜";
    }

    return Row(
      children: [
        SizedBox(width: 12.w),
        buildNetImage(model.logo, width: 20, placeholder: "common/logoQiudui"),
        SizedBox(width: 12.w),
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
        SizedBox(width: 2.w),
        SizedBox(
          width: 62.w,
          child: Text(
            text1,
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
            text2,
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
            text3,
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
            text4,
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
