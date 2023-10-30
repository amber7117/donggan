import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/chat/chat_page.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/main/tabbar/match_detail_tabbar_item_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/page/analysis/match_detail_analysis_page.dart';
import 'package:wzty/modules/match/page/anchor/match_detail_anchor_page.dart';
import 'package:wzty/modules/match/page/status/match_detail_bb_status_page.dart';
import 'package:wzty/modules/match/page/status/match_detail_fb_status_page.dart';
import 'package:wzty/modules/match/provider/match_detail_data_provider.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_video_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_web_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

const double _headHeight = 212.0;

class MatchDetailPage extends StatefulWidget {
  final int matchId;

  const MatchDetailPage({super.key, required this.matchId});

  @override
  State createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends State<MatchDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();
  final MatchDetailDataProvider _detailProvider = MatchDetailDataProvider();

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
    const MatchDetailTabbarItemWidget(
      tabName: '聊球',
      index: 4,
    )
  ];

  LoadStatusType _layoutState = LoadStatusType.loading;
  MatchDetailModel? _model;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _requestData();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _pageController.dispose();
  }

  _requestData() {
    ToastUtils.showLoading();

    MatchDetailService.requestMatchDetail(widget.matchId, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result != null) {
          _model = result;

          _layoutState = LoadStatusType.success;
        } else {
          _layoutState = LoadStatusType.empty;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: Colors.white, body: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }

    SportType sportType = SportType.football;
    if (_model!.sportId == SportType.basketball.value) {
      sportType = SportType.basketball;
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context2) => _tabProvider),
          ChangeNotifierProvider(create: (context2) => _detailProvider),
        ],
        child: Column(
          children: [
            Consumer<MatchDetailDataProvider>(
                builder: (context, provider, child) {
              if (provider.showAnimate) {
                return MatchDetailHeadWebWidget(
                    height: _headHeight, urlStr: _model!.animUrl);
              } else if (provider.showVideo) {
                return MatchDetailHeadVideoWidget(
                    height: _headHeight, urlStr: _model!.obtainFirstVideoUrl());
              } else {
                return MatchDetailHeadWidget(
                    height: _headHeight, model: _model!);
              }
            }),
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
                child: PageView.builder(
                    itemCount: _tabs.length,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) {
                      if (index == 0) {
                        if (sportType == SportType.football) {
                          return MatchDetailFBStatusPage(
                              matchId: widget.matchId, detailModel: _model!);
                        } else {
                          return MatchDetailBBStatusPage(
                              matchId: widget.matchId, detailModel: _model!);
                        }
                      } else if (index == 1) {
                        return const SizedBox();
                      } else if (index == 2) {
                        return MatchDetailAnalysisPage(
                            matchId: widget.matchId, detailModel: _model!);
                      } else if (index == 3) {
                        return MatchDetailAnchorPage(matchId: widget.matchId);
                      } else if (index == 4) {
                        return ChatPage(
                            roomId: _model!.roomId,
                            chatRoomId: _model!.matchId.toString());
                      }
                      return const SizedBox();
                    }))
          ],
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
