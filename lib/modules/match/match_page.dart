import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/widget/home_search_widget.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/main/tabbar/home_tabbar_dot_item_widget.dart';
import 'package:wzty/modules/match/manager/match_collect_manager.dart';
import 'package:wzty/modules/match/page/match_child_collect_page.dart';
import 'package:wzty/modules/match/page/match_child_page.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:provider/provider.dart';


const _tabWidth = 56.0;
const _tabHeight = 40.0;

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MatchPageState();
  }
}

class _MatchPageState extends KeepAliveWidgetState
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabDotProvider _tabProvider = TabDotProvider(
      MatchCollectManager.instance.obtainCollectCount(SportType.football));

  late StreamSubscription _eventSub;

  final List<Widget> _tabs = [
    const HomeTabbarDotItemWidget(
      tabName: '及时',
      tabWidth: _tabWidth,
      tabHeight: _tabHeight,
      index: 0,
    ),
    const HomeTabbarDotItemWidget(
      tabName: '赛程',
      tabWidth: _tabWidth,
      tabHeight: _tabHeight,
      index: 1,
    ),
    const HomeTabbarDotItemWidget(
      tabName: '赛果',
      tabWidth: _tabWidth,
      tabHeight: _tabHeight,
      index: 2,
    ),
    const HomeTabbarDotItemWidget(
      tabName: '收藏',
      tabWidth: _tabWidth,
      tabHeight: _tabHeight,
      index: 3,
    )
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _eventSub = eventBusManager.on<MatchCollectDataEvent>((event) {
      if (mounted && event.sportType == SportType.football) {
        _tabProvider.setDotNum(event.value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _pageController.dispose();

    eventBusManager.off(_eventSub);
  }

  @override
  Widget buildWidget(BuildContext context) {
    double tabbarPadding =
        (ScreenUtil().screenWidth - _tabs.length * _tabWidth) / (_tabs.length + 1);
    tabbarPadding = tabbarPadding * 0.5;

    return ChangeNotifierProvider<TabDotProvider>(
        create: (context2) => _tabProvider,
        child: Scaffold(
          backgroundColor: ColorUtils.gray248,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: ScreenUtil().statusBarHeight + 88.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: JhImageUtils.getAssetImage("common/bgHomeTop"),
                      fit: BoxFit.fitWidth),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenUtil().statusBarHeight),
                    HomeSearchWidget(
                        type: HomeSearchType.match, searchTap: () {}),
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
                          labelPadding: EdgeInsets.only(
                              left: tabbarPadding, right: tabbarPadding),
                          tabs: _tabs),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: PageView.builder(
                      key: const Key('pageView'),
                      itemCount: 4,
                      onPageChanged: _onPageChange,
                      controller: _pageController,
                      itemBuilder: (_, int index) {
                        MatchStatus status = MatchStatus.unknown;
                        if (index > 2) {
                          return MatchChildCollectPage(
                              sportType: SportType.football,
                              matchStatus: status);
                        }
                        if (index == 0) {
                          status = MatchStatus.going;
                        } else if (index == 1) {
                          status = MatchStatus.uncoming;
                        } else if (index == 2) {
                          status = MatchStatus.finished;
                        }
                        return MatchChildPage(
                            sportType: SportType.football, matchStatus: status);
                      }))
            ],
          ),
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
