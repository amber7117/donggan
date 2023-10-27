import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';
import 'package:wzty/modules/match/widget/detail/match_status_live_cell_widget.dart';

class MatchStatusLivePage extends StatefulWidget {
  final List<MatchStatusFBLiveModel> liveModelArr;
  final List<MatchStatusFBEventModel> live2ModelArr;

  const MatchStatusLivePage(
      {super.key, required this.liveModelArr, required this.live2ModelArr});

  @override
  State createState() => _MatchStatusLivePageState();
}

class _MatchStatusLivePageState extends State<MatchStatusLivePage> {
  LoadStatusType _layoutState = LoadStatusType.success;

  @override
  Widget build(BuildContext context) {
    if (widget.liveModelArr.isEmpty && widget.live2ModelArr.isEmpty) {
      _layoutState = LoadStatusType.empty;
    }
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    List<MatchStatusFBLiveModel> liveModelArr = widget.liveModelArr;

    if (liveModelArr.isNotEmpty) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: liveModelArr.length,
          itemExtent: statusLiveCellHeight,
          itemBuilder: (context, index) {
            return MatchStatusLiveCellWidget();
          });
    } else {
      List<MatchStatusFBEventModel> live2ModelArr = widget.live2ModelArr;

      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: live2ModelArr.length,
          itemExtent: statusLiveCellHeight,
          itemBuilder: (context, index) {
            return MatchStatusLiveCellWidget();
          });
    }
  }
}
