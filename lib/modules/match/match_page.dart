import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/home_search_widget.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/main/tabbar/home_tabbar_dot_item_widget.dart';
import 'package:wzty/modules/match/manager/match_collect_manager.dart';
import 'package:wzty/modules/match/page/match_child_collect_page.dart';
import 'package:wzty/modules/match/page/match_child_page.dart';
import 'package:wzty/modules/match/provider/match_data_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:provider/provider.dart';

class MatchPage extends StatefulWidget {
  final SportType sportType;

  const MatchPage({super.key, required this.sportType});

  @override
  State<StatefulWidget> createState() {
    return _MatchPageState();
  }
}

class _MatchPageState extends KeepAliveWidgetState<MatchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  late TabDotProvider _tabProvider;
  final MatchDataProvider _dataProvider = MatchDataProvider();

  late StreamSubscription _eventSub;

  final GlobalKey<MatchChildPageState> _goingPageKey = GlobalKey();
  final GlobalKey<MatchChildPageState> _uncomingPageKey = GlobalKey();
  final GlobalKey<MatchChildPageState> _finishedPageKey = GlobalKey();

  final List<Widget> _tabs = [
    const HomeTabbarDotItemWidget(
      tabName: '及时',
      index: 0,
    ),
    const HomeTabbarDotItemWidget(
      tabName: '赛程',
      index: 1,
    ),
    const HomeTabbarDotItemWidget(
      tabName: '赛果',
      index: 2,
    ),
    const HomeTabbarDotItemWidget(
      tabName: '收藏',
      index: 3,
    )
  ];

  _getMatchStatus(int idx) {
    if (idx == 0) {
      return MatchStatus.going;
    } else if (idx == 1) {
      return MatchStatus.uncoming;
    } else if (idx == 2) {
      return MatchStatus.finished;
    }
    return MatchStatus.uncoming;
  }

  _getMatchDateStr(int idx) {
    if (idx == 0) {
      return _goingPageKey.currentState?.getMatchDateStr();
    } else if (idx == 1) {
      return _uncomingPageKey.currentState?.getMatchDateStr();
    } else if (idx == 2) {
      return _finishedPageKey.currentState?.getMatchDateStr();
    }
    return "";
  }

  @override
  void initState() {
    super.initState();

    _tabProvider = TabDotProvider(
        MatchCollectManager.instance.obtainCollectCount(widget.sportType));

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _eventSub = eventBusManager.on<MatchCollectDataEvent>((event) {
      if (mounted && event.sportType == widget.sportType) {
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
        (ScreenUtil().screenWidth - _tabs.length * homeDotItemWidth) /
            (_tabs.length + 1);
    tabbarPadding = tabbarPadding * 0.5;

    SportType sportType = widget.sportType;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context2) => _tabProvider),
          ChangeNotifierProvider(create: (context2) => _dataProvider),
        ],
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: ScreenUtil().statusBarHeight),
                    Consumer<TabDotProvider>(
                        builder: (context, provider, child) {
                      return HomeSearchWidget(
                          type: HomeSearchType.match,
                          searchTap: () {
                            Routes.present(context, Routes.search);
                          },
                          rightTap: provider.index == 3
                              ? null
                              : () {
                                  Routes.present(context, Routes.matchFilter,
                                      arguments: {
                                        "sportType": sportType,
                                        "matchStatus":
                                            _getMatchStatus(_tabProvider.index),
                                        "dateStr": _getMatchDateStr(
                                            _tabProvider.index),
                                      });
                                });
                    }),
                    const SizedBox(height: 6.0),
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
                      itemCount: _tabs.length,
                      onPageChanged: _onPageChange,
                      controller: _pageController,
                      itemBuilder: (_, int index) {
                        MatchStatus status = MatchStatus.unknown;
                        if (index > 2) {
                          return MatchChildCollectPage(sportType: sportType);
                        }
                        GlobalKey key;
                        if (index == 0) {
                          status = MatchStatus.going;
                          key = _goingPageKey;
                        } else if (index == 1) {
                          status = MatchStatus.uncoming;
                          key = _uncomingPageKey;
                        } else {
                          status = MatchStatus.finished;
                          key = _finishedPageKey;
                        }
                        return MatchChildPage(
                            key: key,
                            sportType: sportType,
                            matchStatus: status);
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
