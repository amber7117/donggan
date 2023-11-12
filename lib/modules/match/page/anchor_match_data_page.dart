import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/main/tabbar/match_detail_tabbar_item_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/page/analysis/match_detail_analysis_page.dart';
import 'package:wzty/modules/match/page/anchor/match_detail_anchor_page.dart';
import 'package:wzty/modules/match/page/lineup/match_detail_bb_lineup_page.dart';
import 'package:wzty/modules/match/page/lineup/match_detail_fb_lineup_page.dart';
import 'package:wzty/modules/match/page/status/match_detail_bb_status_page.dart';
import 'package:wzty/modules/match/page/status/match_detail_fb_status_page.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class AnchorMatchDataPage extends StatefulWidget {
  final int matchId;

  final VoidCallback callback;

  const AnchorMatchDataPage(
      {super.key, required this.matchId, required this.callback});

  @override
  State createState() => AnchorMatchDataPageState();
}

class AnchorMatchDataPageState
    extends KeepAliveLifeWidgetState<AnchorMatchDataPage>
    with SingleTickerProviderStateMixin {
      
  setDetailModel(MatchDetailModel model) {
    if (_model != null) return;
    
    _model = model;
    setState(() {
      
    });
  }

  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();

  final List<Widget> _tabs = [
    const MatchDetailTabbarItemWidget(
      tabName: '赛况',
      index: 0,
    ),
    const MatchDetailTabbarItemWidget(
      tabName: '阵容',
      index: 1,
    ),
    const MatchDetailTabbarItemWidget(
      tabName: '分析',
      index: 2,
    ),
    const MatchDetailTabbarItemWidget(
      tabName: '主播',
      index: 3,
    ),
  ];

  MatchDetailModel? _model;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _pageController.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return _buildChild(context);
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }

    MatchDetailModel model = _model!;

    SportType sportType = SportType.football;
    if (model.sportId == SportType.basketball.value) {
      sportType = SportType.basketball;
    }

    return ChangeNotifierProvider<TabProvider>(
        create: (context2) => _tabProvider,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: TabBar(
                  onTap: (index) {
                    if (!mounted) return;
                    _pageController.jumpToPage(index);
                  },
                  isScrollable: false,
                  controller: _tabController,
                  indicator: const BoxDecoration(),
                  labelPadding: const EdgeInsets.only(left: 10, right: 10),
                  tabs: _tabs),
            ),
            const ColoredBox(
                color: Color.fromRGBO(236, 236, 236, 1.0),
                child: SizedBox(width: double.infinity, height: 0.5)),
            Expanded(
                child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                PageView.builder(
                    itemCount: _tabs.length,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) {
                      if (index == 0) {
                        if (sportType == SportType.football) {
                          return MatchDetailFBStatusPage(
                              matchId: widget.matchId, detailModel: model);
                        } else {
                          return MatchDetailBBStatusPage(
                              matchId: widget.matchId, detailModel: model);
                        }
                      } else if (index == 1) {
                        if (sportType == SportType.football) {
                          return MatchDetailFBLineupPage(
                              matchId: widget.matchId, detailModel: model);
                        } else {
                          return MatchDetailBBLineupPage(
                              matchId: widget.matchId, detailModel: model);
                        }
                      } else if (index == 2) {
                        return MatchDetailAnalysisPage(
                            matchId: widget.matchId, detailModel: model);
                      } else if (index == 3) {
                        return MatchDetailAnchorPage(matchId: widget.matchId);
                      }
                      return const SizedBox();
                    }),
                InkWell(
                  onTap: widget.callback,
                  child: Container(
                    width: 22,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: JhImageUtils.getAssetImage(
                              "anchor/icon_shuju_left"),
                          fit: BoxFit.cover),
                    ),
                    child: const Text("主\n播",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w400)),
                  ),
                )
              ],
            ))
          ],
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }
}
