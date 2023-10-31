import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/home_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_tech_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';
import 'package:wzty/modules/match/widget/status/match_status_bb_live_cell_widget.dart';
import 'package:wzty/modules/match/widget/status/match_status_segment_widget.dart';

class MatchStatusBBLivePage extends StatefulWidget {
  final MatchStatusBBLiveLocalModel? liveModel;
  final MatchStatusBBLiveLocalModel? live2Model;

  const MatchStatusBBLivePage({super.key, this.liveModel, this.live2Model});

  @override
  State createState() => _MatchStatusBBLivePageState();
}

class _MatchStatusBBLivePageState extends State<MatchStatusBBLivePage>{

  LoadStatusType _layoutState = LoadStatusType.success;

  @override
  Widget build(BuildContext context) {
    if (widget.liveModel == null && widget.live2Model == null) {
      _layoutState = LoadStatusType.empty;
    }
    return LoadStateWidget(
        state: _layoutState, successWidget: _prepareBuildChild(context));
  }

  _prepareBuildChild(BuildContext context) {
    MatchStatusBBLiveLocalModel liveModel;
    bool is2 = false;
    if (widget.liveModel != null) {
      liveModel = widget.liveModel!;
    } else {
      is2 = true;
      liveModel = widget.live2Model!;
    }

    return _buildChild(context, liveModel.modelArr2[0], is2);
  }

  _buildChild(BuildContext context, List<dynamic> modelArr2, bool is2) {
    MatchStatusBBLiveLocalModel liveModel;
    bool is2 = false;
    if (widget.liveModel != null) {
      liveModel = widget.liveModel!;
    } else {
      is2 = true;
      liveModel = widget.live2Model!;
    }
    
    return Column(
      children: [
        MatchStatusSegmentWidget(titleArr: liveModel.titleArr, selectIdx: 0),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: modelArr2.length,
              itemExtent: 42.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (is2) {
                  return MatchStatusBbLiveCellWidget(
                      live2Model: modelArr2[index] as MatchStatusFBEventModel);
                } else {
                  return MatchStatusBbLiveCellWidget(
                      liveModel: modelArr2[index] as MatchStatusFBLiveModel);
                }
              }),
        )
      ],
    );
  }
}
