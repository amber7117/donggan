import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/widget/detail/match_status_event_cell_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_status_team_widget.dart';

class MatchStatusEventPage extends StatefulWidget {
  final MatchDetailModel detailModel;
  final List<MatchStatusFBEventModel> eventModelArr;

  const MatchStatusEventPage(
      {super.key, required this.eventModelArr, required this.detailModel});

  @override
  State createState() => _MatchStatusEventPageState();
}

class _MatchStatusEventPageState extends State<MatchStatusEventPage> {
  LoadStatusType _layoutState = LoadStatusType.success;

  @override
  Widget build(BuildContext context) {
    if (widget.eventModelArr.isEmpty) {
      _layoutState = LoadStatusType.empty;
    }
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    List<MatchStatusFBEventModel> eventModelArr = widget.eventModelArr;
    return ColoredBox(
      color: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 3),
          itemCount: eventModelArr.length + 1,
          itemExtent: statusEventCellHeight,
          itemBuilder: (context, index) {
            if (index == 0) {
              return MatchStatusTeamWidget(detailModel: widget.detailModel);
            }
            return MatchStatusEventCellWidget(model: eventModelArr[index-1]);
          }),
    );
  }
}
