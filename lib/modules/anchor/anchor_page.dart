import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/widget/home_search_widget.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/tabbar/home_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/anchor/page/anchor_child_hot_page.dart';
import 'package:wzty/modules/anchor/page/anchor_child_page.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

const _tabWidth = 56.0;
const _tabHeight = 40.0;

class AnchorPage extends StatefulWidget {
  const AnchorPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnchorPageState();
  }
}

class _AnchorPageState extends KeepAliveWidgetState
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();

  final List<Widget> _tabs = [
    const HomeTabbarItemWidget(
      tabName: '推荐',
      index: 0,
    ),
    const HomeTabbarItemWidget(
      tabName: '足球',
      index: 1,
    ),
    const HomeTabbarItemWidget(
      tabName: '篮球',
      index: 2,
    ),
    const HomeTabbarItemWidget(
      tabName: '其他',
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
    super.dispose();

    _tabController.dispose();
    _pageController.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    double tabbarPadding =
        (ScreenUtil().screenWidth - _tabs.length * _tabWidth) /
            (_tabs.length + 1);
    tabbarPadding = tabbarPadding * 0.5;

    return ChangeNotifierProvider<TabProvider>(
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
                      key: const Key('pageView'),
                      itemCount: _tabs.length,
                      onPageChanged: _onPageChange,
                      controller: _pageController,
                      itemBuilder: (_, int index) {
                        if (index == 0) {
                          return const AnchorChildHotPage();
                        } else if (index == 1) {
                          return const AnchorChildPage(
                              type: LiveSportType.football);
                        } else if (index == 2) {
                          return const AnchorChildPage(
                              type: LiveSportType.basketball);
                        } else {
                          return const AnchorChildPage(
                              type: LiveSportType.other);
                        }
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
