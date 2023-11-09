import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_score_entity.dart';
import 'package:wzty/modules/match/widget/status/match_status_bb_score_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusBBScoreWidget extends StatelessWidget {
  final MatchDetailModel detailModel;
  final MatchStatusBBScoreModel? scoreModel;

  const MatchStatusBBScoreWidget(
      {super.key, required this.detailModel, this.scoreModel});

  @override
  Widget build(BuildContext context) {
    int cnt = scoreModel?.dataModelArr.length ?? 0;
    double width = cnt * statusBBScoreCellWidth;
    return SizedBox(
      width: double.infinity,
      height: 116,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildHeadWidget()),
          SizedBox(
            width: width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: cnt,
                itemExtent: statusBBScoreCellWidth,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return MatchStatusBBScoreCellWidget(
                      model: scoreModel!.dataModelArr[index]);
                }),
          ),
          const SizedBox(width: 10, height: 36).colored(ColorUtils.gray248),
        ],
      ),
    );
  }

  _buildHeadWidget() {
    return Column(
      children: [
        Container(
            height: 36,
            color: ColorUtils.gray248,
            child: const Row(
              children: [
                SizedBox(width: 10),
                Text(
                  "比赛对阵",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual),
                ),
              ],
            )),
        _buildTeamWidget(detailModel.hostTeamLogo, detailModel.hostTeamName),
        _buildTeamWidget(detailModel.guestTeamLogo, detailModel.guestTeamName),
      ],
    );
  }

  _buildTeamWidget(String logo, String team) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          const SizedBox(width: 10),
          buildNetImage(logo, width: 20, placeholder: "common/logoQiudui"),
          const SizedBox(width: 5),
          SizedBox(
            width: 65,
            child: Text(
              team,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
        ],
      ),
    );
  }
}
