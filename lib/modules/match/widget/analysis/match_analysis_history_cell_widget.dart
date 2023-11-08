import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisHistoryCellWidget extends StatelessWidget {
  final MatchAnalysisMatchModel model;
  final SportType sportType;
  final String mainTeamName;

  const MatchAnalysisHistoryCellWidget(
      {super.key,
      required this.model,
      required this.sportType,
      required this.mainTeamName});

  @override
  Widget build(BuildContext context) {
    double vsWidth = 44.0.w;
    double vsPadding = 11.0.w;
    if (sportType == SportType.basketball) {
      vsWidth = 54.0.w;
      vsPadding = 1.0.w;
    }

    Color text1Color = ColorUtils.black34;
    Color text2Color = ColorUtils.black34;
    Color scoreColor = ColorUtils.black34;
    if (model.hostTeamName == mainTeamName) {
      text2Color = ColorUtils.gray153;
      if (model.hostTeamScore > model.guestTeamScore) {
        scoreColor = ColorUtils.red255;
      } else if (model.hostTeamScore < model.guestTeamScore) {
        scoreColor = ColorUtils.green0;
      }
    } else {
      text1Color = ColorUtils.gray153;

      if (model.hostTeamScore > model.guestTeamScore) {
        scoreColor = ColorUtils.green0;
      } else if (model.hostTeamScore < model.guestTeamScore) {
        scoreColor = ColorUtils.red255;
      }
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
        SizedBox(width: vsPadding),
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
          width: vsWidth,
          child: Text(
            "${model.hostTeamScore}-${model.guestTeamScore}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: scoreColor,
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
            "${model.hostTeamHalfScore}-${model.guestTeamHalfScore}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
      ],
    );
  }
}
