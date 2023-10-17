import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/match_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/anchor/entity/live_detail_entity.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/chat/chat_page.dart';
import 'package:wzty/modules/match/entity/match_detail_entity.dart';
import 'package:wzty/modules/match/page/match_detail_anchor_page.dart';
import 'package:wzty/modules/match/page/match_detail_status_page.dart';
import 'package:wzty/modules/match/provider/matc_detail_provider.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_video_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_web_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

const double _headHeight = 212.0;

class AnchorDetailPage extends StatefulWidget {
  final int anchorId;

  const AnchorDetailPage({super.key, required this.anchorId});

  @override
  State createState() => _AnchorDetailPageState();
}

class _AnchorDetailPageState extends State<AnchorDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();
  final MatchDetailProvider _detailProvider = MatchDetailProvider();

  final List<Widget> _tabs = [
    const MatchTabbarItemWidget(
      tabName: '聊球',
      index: 0,
    ),
    const MatchTabbarItemWidget(
      tabName: '预告',
      index: 1,
    ),
    const MatchTabbarItemWidget(
      tabName: '回放',
      index: 2,
    ),
  ];

  LoadStatusType _layoutState = LoadStatusType.loading;
  LiveDetailModel? _model;

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

    Future basic = AnchorService.requestDetailBasicInfo(widget.anchorId, (success, result) { 
      _model = result;
    });
     Future play = AnchorService.requestDetailPlayInfo(
        widget.anchorId, (success, result) {});

    Future.wait([basic, play]).then((value) {
      ToastUtils.hideLoading();

      if (_model != null) {
        _layoutState = LoadStatusType.success;
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
              // if (provider.showAnimate) {
              //   return MatchDetailHeadWebWidget(
              //       height: _headHeight, urlStr: _model!.animUrl);
              // } else if (provider.showVideo) {
              //   return MatchDetailHeadVideoWidget(
              //       height: _headHeight, urlStr: _model!.obtainFirstVideoUrl());
              // } else {
                return SizedBox();
              // }
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
                    itemCount: _tabs.length,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) {
                      // if (index == 3) {
                      //   return MatchDetailAnchorPage(matchId: widget.matchId);
                      // } else if (index == 4) {
                      //   return ChatPage(
                      //       roomId: _model!.roomId,
                      //       chatRoomId: _model!.matchId.toString());
                      // }
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
