import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/common/chat/chat_page.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/main/tabbar/match_tabbar_item_widget.dart';
import 'package:wzty/modules/match/entity/match_detail_entity.dart';
import 'package:wzty/modules/match/page/match_detail_anchor_page.dart';
import 'package:wzty/modules/match/page/match_detail_status_page.dart';
import 'package:wzty/modules/match/provider/matc_detail_provider.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_video_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_web_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_widget.dart';
import 'package:wzty/utils/color_utils.dart';
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
  final MatchDetailProvider _detailProvider = MatchDetailProvider();

  final List<Widget> _tabs = [
    const MatchTabbarItemWidget(
      tabName: '赛况',
      index: 0,
    ),
    const MatchTabbarItemWidget(
      tabName: '阵容',
      index: 1,
    ),
    const MatchTabbarItemWidget(
      tabName: '分析',
      index: 2,
    ),
    const MatchTabbarItemWidget(
      tabName: '主播',
      index: 3,
    ),
    const MatchTabbarItemWidget(
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
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context2) => _tabProvider),
          ChangeNotifierProvider(create: (context2) => _detailProvider),
        ],
        child: Column(
          children: [
            Consumer<MatchDetailProvider>(builder: (context, provider, child) {
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
                    key: const Key('pageView'),
                    itemCount: 5,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) {
                      if (index == 3) {
                        return MatchDetailAnchorPage(matchId: widget.matchId);
                      } else if (index == 4) {
                        return ChatPage();
                      }
                      return MatchDetailStatusPage();
                    }))
          ],
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
