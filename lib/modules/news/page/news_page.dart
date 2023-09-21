import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/modules/news/page/news_child_page.dart';
import 'package:wzty/modules/news/widget/news_tabbar_item_widget.dart';
import 'package:wzty/utils/text_style_utils.dart';

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

  final List tabs = ["关注", "足球", "篮球"];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          Container(
            // 隐藏点击效果
            padding: const EdgeInsets.only(left: 16.0),
            color: Colors.yellow,
            child: TabBar(
              onTap: (index) {
                if (!mounted) return;
                _pageController.jumpToPage(index);
              },
              isScrollable: true,
              controller: _tabController,
              labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: TextStyleUtils.medium),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.zero,
              unselectedLabelColor: ColorUtils.rgb(248, 135, 152),
              labelColor: Colors.white,
              indicatorPadding: const EdgeInsets.only(right: 98.0 - 36.0),
              tabs: tabs.map((e) => NewsTabbarItemWidget(tabName: e)).toList(),
            ),
          ),
          // const SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
                key: const Key('pageView'),
                itemCount: 3,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, int index) {
                  return const NewsChildPage();
                }
            )
          )
        ],
      ),
    );
    
  }

  void _onPageChange(int index) {
    _tabController.animateTo(index);
  }

}
