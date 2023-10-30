import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_score_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double statusBBScoreCellWidth = 40.0;

class MatchStatusBBScoreCellWidget extends StatefulWidget {
  final MatchStatusBBScorePeriodLocalModel model;

  const MatchStatusBBScoreCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchStatusBBScoreCellWidgetState();
}

class _MatchStatusBBScoreCellWidgetState extends State<MatchStatusBBScoreCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchStatusBBScorePeriodLocalModel model = widget.model;

    String text1;
    String text2;
    Color color1;
    Color color2;

    if (model.team1 < 0) {
      text1 = "-";
      text2 = "-";

      color1 = ColorUtils.gray149;
      color2 = ColorUtils.gray149;
    } else {
      text1 = "${model.team1}";
      text2 = "${model.team2}";

      if (model.title == "总分") {
        color1 = ColorUtils.red233;
        color2 = ColorUtils.red233;
      } else {
        color1 = ColorUtils.black34;
        color2 = ColorUtils.black34;
      }
    }

    return Column(
      children: [
         Container(
          width: statusBBScoreCellWidth,
          height: 36,
          alignment: Alignment.center,
          color: ColorUtils.gray248,
          child: Text(
            model.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
         Container(
          width: statusBBScoreCellWidth,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text1,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(
                color: color1,
                fontSize: 12,
                fontWeight: TextStyleUtils.medium),
          ),
        ),
         Container(
          width: statusBBScoreCellWidth,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text2,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(
                color: color2,
                fontSize: 12,
                fontWeight: TextStyleUtils.medium),
          ),
        ),
      ],
    );
  }
}