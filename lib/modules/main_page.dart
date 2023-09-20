import 'package:flutter/material.dart';
import 'package:wzty/business/anchor/page/anchor_page.dart';
import 'package:wzty/business/match/page/match_page.dart';
import 'package:wzty/business/me/page/me_page.dart';
import 'package:wzty/business/news/page/news_page.dart';
import 'package:wzty/utils/jh_image_utils.dart';

const double _tabW = 75.0;
const double _tabH = 48.0;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State {
  final List<Widget> _pageList = const [
    AnchorPage(),
    MatchPage(),
    NewsPage(),
    MePage(),
  ];

  List<BottomNavigationBarItem> obtainTabList() {
    return [
      _createItem('common/tab1'),
      _createItem('common/tab2'),
      _createItem('common/tab3'),
      _createItem('common/tab4'),
    ];
  }

  final PageController _pageController = PageController();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageList,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: obtainTabList(),
      // 配置对应的索引值选中
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // 配置对应的索引值选中
      onTap: (int index) {
        setState(() {
          // 改变状态
          _currentIndex = index;
          _pageController.jumpToPage(index);
        });
      },
    );
  }

  _createItem(String imgPath) {
    var item = BottomNavigationBarItem(
      label: "",
      icon: JhAssetImage(imgPath, width: _tabW, height: _tabH),
      activeIcon: JhAssetImage('${imgPath}S', width: _tabW, height: _tabH),
    );
    return item;
  }
}
