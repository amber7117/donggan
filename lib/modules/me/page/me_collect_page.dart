import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/tabbar/match_detail_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/match/page/match_child_collect_page.dart';
import 'package:wzty/utils/color_utils.dart';

class MeCollectPage extends StatefulWidget {
  const MeCollectPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MeCollectPageState();
  }
}

class _MeCollectPageState extends State with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();

  final List<Widget> _tabs = [
    const MatchDetailTabbarItemWidget(
      tabName: '足球',
      index: 0,
    ),
    const MatchDetailTabbarItemWidget(
      tabName: '篮球',
      index: 1,
    ),
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(titleText: "我的收藏"),
        backgroundColor: ColorUtils.gray248,
        body: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context2) => _tabProvider),
        ],
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
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
                child: PageView.builder(
                    itemCount: _tabs.length,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) {
                      if (index == 0) {
                        return const MatchChildCollectPage(
                            sportType: SportType.football, redDot: false);
                      } else if (index == 1) {
                        return const MatchChildCollectPage(
                            sportType: SportType.basketball, redDot: false);
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
