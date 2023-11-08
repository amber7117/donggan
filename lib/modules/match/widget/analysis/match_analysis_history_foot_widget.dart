import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisHistoryFootWidget extends StatelessWidget {
  final SportType sportType;
  final MatchAnalysisHistoryModel model;
  final String logo;
  final String team;

  const MatchAnalysisHistoryFootWidget(
      {super.key,
      required this.sportType,
      required this.model,
      required this.logo,
      required this.team});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.yellow,
      child: Row(
        children: [
          buildNetImage(logo, width: 20, placeholder: "common/logoQiudui"),
          Text(
            team,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          )
        ],
      ),
    );
  }
}
