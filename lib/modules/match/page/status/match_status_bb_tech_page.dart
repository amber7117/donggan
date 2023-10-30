import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_tech_entity.dart';
import 'package:wzty/modules/match/widget/status/match_status_fb_tech_cell_widget.dart';
import 'package:wzty/modules/match/widget/status/match_status_team_widget.dart';

class MatchStatusBBTechPage extends StatefulWidget {
  final MatchDetailModel detailModel;
  final MatchStatusBBTechModel? techModel;
  
  const MatchStatusBBTechPage({super.key, required this.detailModel, this.techModel});


  @override
  State createState() => _MatchStatusBBTechPageState();
}

class _MatchStatusBBTechPageState extends State<MatchStatusBBTechPage> {
  LoadStatusType _layoutState = LoadStatusType.success;

  @override
  Widget build(BuildContext context) {
    if (widget.techModel == null || widget.techModel!.dataModelArr.isEmpty) {
      _layoutState = LoadStatusType.empty;
    }
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    MatchStatusBBTechModel techModel = widget.techModel!;
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: techModel.dataModelArr.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return MatchStatusTeamWidget(detailModel: widget.detailModel);
          }
          return MatchStatusFBTechCellWidget(
              model: techModel.dataModelArr[index - 1]);
        });
  }
}