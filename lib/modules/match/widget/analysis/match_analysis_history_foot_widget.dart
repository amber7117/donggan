import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MatchAnalysisHistoryFootWidget extends StatelessWidget {

  final SportType sportType;
  final MatchAnalysisMatchModel model;
  final String logo;
  final String team;
  
  const MatchAnalysisHistoryFootWidget({super.key, required this.sportType, required this.model, required this.logo, required this.team});



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.yellow,
      child: Row(
        children: [
          buildNetImage(logo, width: 20, placeholder: "common/logoQiudui"),
        ],
      ),
    );
  }
}
