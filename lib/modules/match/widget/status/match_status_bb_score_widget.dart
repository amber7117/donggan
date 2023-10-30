import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_score_entity.dart';
import 'package:wzty/modules/match/widget/status/match_status_bb_score_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusBBScoreWidget extends StatefulWidget {
  final MatchDetailModel detailModel;
  final MatchStatusBBScoreModel? scoreModel;

  const MatchStatusBBScoreWidget(
      {super.key, required this.detailModel, this.scoreModel});

  @override
  State createState() => _MatchStatusBBScoreWidgetState();
}

class _MatchStatusBBScoreWidgetState extends State<MatchStatusBBScoreWidget> {
  @override
  Widget build(BuildContext context) {
    MatchStatusBBScoreModel? scoreModel = widget.scoreModel;
    return SizedBox(
      width: double.infinity,
      height: 148,
      child: Row(
        children: [
          _buildHeadWidget(),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: scoreModel?.dataModelArr.length ?? 0,
                itemExtent: 42.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return MatchStatusBBScoreCellWidget(
                      model: scoreModel!.dataModelArr[index]);
                }),
          )
        ],
      ),
    );
  }

  _buildHeadWidget() {
    MatchDetailModel model = widget.detailModel;
    return Column(
      children: [
        const SizedBox(
          width: 75,
          child: Text(
            "比赛对阵",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        _buildTeamWidget(model.hostTeamLogo, model.hostTeamName),
        _buildTeamWidget(model.guestTeamLogo, model.guestTeamName),
      ],
    );
  }

  _buildTeamWidget(String logo, String team) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            team,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        buildNetImage(logo, width: 20, placeholder: "common/logoQiudui"),
      ],
    );
  }
}
