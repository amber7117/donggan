import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/news/page/news_child_page.dart';
import 'package:wzty/main/tabbar/home_tabbar_item_widget.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();

  final List<Widget> _tabs = [
    const HomeTabbarItemWidget(
      tabName: '及时',
      index: 0,
    ),
    const HomeTabbarItemWidget(
      tabName: '赛程',
      index: 1,
    ),
    const HomeTabbarItemWidget(
      tabName: '赛果',
      index: 2,
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
    _tabController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabProvider>(
        create: (context2) => _tabProvider,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().statusBarHeight + 65.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: JhImageUtils.getAssetImage("common/bgHomeTop"),
                      fit: BoxFit.fitWidth),
                ),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 25.0, right: 10.0),
                  // color: Colors.yellow,
                  child: TabBar(
                      onTap: (index) {
                        if (!mounted) return;
                        _pageController.jumpToPage(index);
                      },
                      isScrollable: true,
                      controller: _tabController,
                      indicator: const BoxDecoration(),
                      labelPadding: EdgeInsets.zero,
                      tabs: _tabs),
                ),
              ),
              Expanded(
                  child: PageView.builder(
                      key: const Key('pageView'),
                      itemCount: 3,
                      onPageChanged: _onPageChange,
                      controller: _pageController,
                      itemBuilder: (_, int index) {
                        return const NewsChildPage();
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
