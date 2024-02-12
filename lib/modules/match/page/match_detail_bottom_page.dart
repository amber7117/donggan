import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/main/tabbar/match_detail_tabbar_item_widget.dart';
import 'package:wzty/modules/chat/chat_page.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/page/analysis/match_detail_analysis_page.dart';
import 'package:wzty/modules/match/page/anchor/match_detail_anchor_page.dart';
import 'package:wzty/modules/match/page/lineup/match_detail_bb_lineup_page.dart';
import 'package:wzty/modules/match/page/lineup/match_detail_fb_lineup_page.dart';
import 'package:wzty/modules/match/page/status/match_detail_bb_status_page.dart';
import 'package:wzty/modules/match/page/status/match_detail_fb_status_page.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MatchDetailBottomPage extends StatefulWidget {
  final int matchId;
  final bool showChat;
  final MatchDetailModel? model;
  final VoidCallback? callback;

  const MatchDetailBottomPage(
      {super.key,
      required this.matchId,
      this.showChat = true,
      this.callback,
      this.model});

  @override
  State createState() => MatchDetailBottomPageState();
}

class MatchDetailBottomPageState
    extends KeepAliveLifeWidgetState<MatchDetailBottomPage>
    with SingleTickerProviderStateMixin {
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
  ];
  final List<String> _tabTitles = [
    '赛况',
    '阵容',
    '分析',
  ];

  MatchDetailModel? _model;

  @override
  void initState() {
    super.initState();

    _model = widget.model;

    if (ConfigManager.instance.liveOk) {
      _tabTitles.add('主播');
      _tabs.add(const MatchDetailTabbarItemWidget(
        tabName: '主播',
        index: 3,
      ));
    }

    if (widget.showChat) {
      int tabCnt = _tabs.length;
      _tabTitles.add('聊球');
      _tabs.add(MatchDetailTabbarItemWidget(
        tabName: '聊球',
        index: tabCnt,
      ));
    }

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
        child: ColoredBox(
          color: Colors.white,
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
                    dividerHeight: 0.0,
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
                        String title = _tabTitles[index];
                        if (title == "赛况") {
                          if (sportType == SportType.football) {
                            return MatchDetailFBStatusPage(
                                matchId: widget.matchId, detailModel: model);
                          } else {
                            return MatchDetailBBStatusPage(
                                matchId: widget.matchId, detailModel: model);
                          }
                        } else if (title == "阵容") {
                          if (sportType == SportType.football) {
                            return MatchDetailFBLineupPage(
                                matchId: widget.matchId, detailModel: model);
                          } else {
                            return MatchDetailBBLineupPage(
                                matchId: widget.matchId, detailModel: model);
                          }
                        } else if (title == "分析") {
                          return MatchDetailAnalysisPage(
                              matchId: widget.matchId, detailModel: model);
                        } else if (title == "主播") {
                          return MatchDetailAnchorPage(matchId: widget.matchId);
                        } else if (title == "聊球") {
                          return ChatPage(
                              roomId: model.roomId,
                              chatRoomId: model.matchId.toString(),
                              isMatch: true);
                        }
                        return const SizedBox();
                      }),
                  Visibility(
                    visible: widget.callback != null,
                    child: InkWell(
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
                    ),
                  )
                ],
              ))
            ],
          ),
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
