import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';
import 'package:wzty/modules/match/widget/detail/match_status_team_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_status_tech_cell_widget.dart';

class MatchStatusTechPage extends StatefulWidget {
  final MatchDetailModel detailModel;
  final MatchStatusFBTechModel? techModel;
  
  const MatchStatusTechPage({super.key, this.techModel, required this.detailModel});

  @override
  State createState() => _MatchStatusTechPageState();
}

class _MatchStatusTechPageState extends State<MatchStatusTechPage> {
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
    MatchStatusFBTechModel techModel = widget.techModel!;
    return ListView.builder(
        padding:  EdgeInsets.zero,
        itemCount: techModel.dataModelArr.length + 1,
        // itemExtent: statusTechCellHeight,
        itemBuilder: (context, index) {
          if (index == 0) {
            return MatchStatusTeamWidget(detailModel: widget.detailModel);
          }
          return MatchStatusTechCellWidget(
              model: techModel.dataModelArr[index-1]);
        });
  }
}
