import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/match_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/match/entity/match_filter_entity.dart';
import 'package:wzty/modules/match/page/filter/match_filter_all_page.dart';
import 'package:wzty/modules/match/page/filter/match_filter_hot_page.dart';

import 'package:wzty/modules/match/provider/matc_detail_provider.dart';
import 'package:wzty/modules/match/service/match_filter_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchFilterPage extends StatefulWidget {
  final SportType sportType;
  final MatchStatus matchStatus;
  final String dateStr;

  const MatchFilterPage({
    super.key,
    required this.sportType,
    required this.matchStatus,
    required this.dateStr,
  });

  @override
  State createState() => _MatchFilterPageState();
}

class _MatchFilterPageState extends State<MatchFilterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();
  final MatchDetailProvider _detailProvider = MatchDetailProvider();

  final List<Widget> _tabs = [
    const MatchTabbarItemWidget(
      tabName: '全部',
      index: 0,
      tabWidth: 60.0,
      tabHeight: 44.0,
    ),
    const MatchTabbarItemWidget(
      tabName: '热门',
      index: 1,
      tabWidth: 60.0,
      tabHeight: 44.0,
    ),
  ];

  LoadStatusType _layoutState = LoadStatusType.loading;
  MatchFilterModel? _allData;
  MatchFilterModel? _hotData;

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

    Future all = MatchFilterService.requestAllData(
        MatchFilterType.footballAll, widget.matchStatus, "2023-10-19",
        (success, result) {
      _allData = result;
    });
    Future hot = MatchFilterService.requestHotData(MatchFilterType.footballHot,
        (success, result) {
      _hotData = result;
    });

    Future.wait([all, hot]).then((value) {
      ToastUtils.hideLoading();

      if (_allData != null && _hotData != null) {
        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.failure;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context: context, titleText: "足球赛事"),
      body: LoadStateWidget(
          state: _layoutState, successWidget: _buildChild(context)),
    );
  }

  _buildChild(BuildContext context) {
    if (_allData == null || _hotData == null) {
      return const SizedBox();
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context2) => _tabProvider),
          ChangeNotifierProvider(create: (context2) => _detailProvider),
        ],
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 240,
                child: TabBar(
                    onTap: (index) {
                      if (!mounted) return;
                      _pageController.jumpToPage(index);
                    },
                    isScrollable: true,
                    controller: _tabController,
                    indicator: const BoxDecoration(),
                    labelPadding: const EdgeInsets.only(left: 30, right: 30),
                    tabs: _tabs),
              ),
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
                      if (index == 0) {
                        return MatchFilterAllPage();
                      } else {
                        return MatchFilterHotPage();
                      }
                    }))
          ],
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
