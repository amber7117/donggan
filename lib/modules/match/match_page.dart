import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/tabbar/home_tab_provider.dart';
import 'package:wzty/modules/match/page/match_child_collect_page.dart';
import 'package:wzty/modules/match/page/match_child_page.dart';
import 'package:wzty/main/tabbar/home_tabbar_item_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:provider/provider.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MatchPageState();
  }
}

class _MatchPageState extends BaseWidgetState
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  HomeTabProvider provider = HomeTabProvider();

  final List<Widget> _tabs = [
    const HomeTabbarItemWidget(
      tabName: '及时',
      tabWidth: 56,
      index: 0,
    ),
    const HomeTabbarItemWidget(
      tabName: '赛程',
      tabWidth: 56,
      index: 1,
    ),
    const HomeTabbarItemWidget(
      tabName: '赛果',
      tabWidth: 56,
      index: 2,
    ),
    const HomeTabbarItemWidget(
      tabName: '收藏',
      tabWidth: 56,
      index: 3,
    )
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }

  @override
  Widget buildWidget(BuildContext context) {
    double tabbarPadding =
        (ScreenUtil().screenWidth - _tabs.length * 56) / (_tabs.length + 1);
    tabbarPadding = tabbarPadding * 0.5;

    return ChangeNotifierProvider<HomeTabProvider>(
        create: (context2) => provider,
        child: Scaffold(
          backgroundColor: ColorUtils.gray248,
          body: Column(
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().statusBarHeight + 88.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: JhImageUtils.getAssetImage("common/bgHomeTop"),
                      fit: BoxFit.fitWidth),
                ),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
                  padding: const EdgeInsets.only(top: 48.0),
                  // color: Colors.yellow,
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
    provider.setIndex(index);
    _tabController.animateTo(index);
  }
}
