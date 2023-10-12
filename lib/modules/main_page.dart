import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/im/im_manager.dart';
import 'package:wzty/modules/anchor/anchor_page.dart';
import 'package:wzty/modules/match/match_page.dart';
import 'package:wzty/modules/me/me_page.dart';
import 'package:wzty/modules/news/news_page.dart';
import 'package:wzty/utils/jh_image_utils.dart';

const double _tabW = 44.0;
const double _tabH = 44.0;

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
      _buildBarItem('tab/iconZhibo'),
      _buildBarItem('tab/iconLanqiu'),
      _buildBarItem('tab/iconZixun'),
      _buildBarItem('tab/iconWode'),
    ];
  }

  late PageController _pageController;
  int _currentIndex = 0;

  late StreamSubscription _eventSub;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _eventSub = eventBusManager.on<DomainStateEvent>((event) {
      if (event.ok) {
        IMManager.instance.prepareInitSDK();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
    eventBusManager.off(_eventSub);
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
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: obtainTabList(),
      // 配置对应的索引值选中
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: _tabW,
      unselectedFontSize: 0,
      selectedFontSize: 0,
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

  _buildBarItem(String imgPath) {
    var item = BottomNavigationBarItem(
      label: "",
      icon: JhAssetImage(imgPath, width: _tabW, height: _tabH),
      activeIcon: JhAssetImage('${imgPath}S', width: _tabW, height: _tabH),
    );
    return item;
  }
}
