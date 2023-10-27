import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/widget/detail/match_status_event_cell_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_status_team_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

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
          padding: EdgeInsets.zero,
          itemCount: eventModelArr.length + 1,
          // itemExtent: statusEventCellHeight,
          itemBuilder: (context, index) {
            if (index == 0) {
              return MatchStatusTeamWidget(detailModel: widget.detailModel);
            }
            MatchStatusFBEventModel model = eventModelArr[index - 1];
            if (model.team < 1) {
              return _buildHintWidget(model);
            }
            return MatchStatusEventCellWidget(model: model);
          }),
    );
  }

  _buildHintWidget(MatchStatusFBEventModel model) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
      height: 46,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(242, 242, 242, 1),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Text(
        model.content,
        style: const TextStyle(
            color: ColorUtils.gray153,
            fontSize: 12,
            fontWeight: TextStyleUtils.regual),
      ),
    );
  }
}
