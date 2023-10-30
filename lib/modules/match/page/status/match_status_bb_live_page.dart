import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/home_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_tech_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';
import 'package:wzty/modules/match/widget/status/match_status_bb_live_cell_widget.dart';

class MatchStatusBBLivePage extends StatefulWidget {
  final MatchStatusBBLiveLocalModel? liveModel;
  final MatchStatusBBLiveLocalModel? live2Model;

  const MatchStatusBBLivePage({super.key, this.liveModel, this.live2Model});

  @override
  State createState() => _MatchStatusBBLivePageState();
}

class _MatchStatusBBLivePageState extends State<MatchStatusBBLivePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TabProvider _tabProvider = TabProvider();
  final List<Widget> _tabs = [];

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

    _tabs.clear();

    int i = 0;
    for (String title in liveModel.titleArr) {
      HomeTabbarItemWidget item = HomeTabbarItemWidget(
        tabName: title,
        index: i,
      );
      _tabs.add(item);
      i++;
    }

    _tabController = TabController(length: _tabs.length, vsync: this);

    return _buildChild(context, liveModel.modelArr2[0], is2);
  }

  _buildChild(BuildContext context, List<dynamic> modelArr2, bool is2) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 66,
          alignment: Alignment.center,
          child: TabBar(
              onTap: (index) {},
              isScrollable: false,
              controller: _tabController,
              indicator: const BoxDecoration(),
              labelPadding: const EdgeInsets.only(left: 10, right: 10),
              tabs: _tabs),
        ),
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
