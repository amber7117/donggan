import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/news/entity/news_label_entity.dart';
import 'package:wzty/modules/news/page/news_child_page.dart';
import 'package:wzty/main/tabbar/home_tabbar_item_widget.dart';
import 'package:wzty/modules/news/service/news_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:provider/provider.dart';
import 'package:wzty/utils/toast_utils.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends KeepAliveLifeWidgetState
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();

  LoadStatusType _layoutState = LoadStatusType.loading;
  final List<HomeTabbarItemWidget> _dataArr = [];

  @override
  void initState() {
    super.initState();

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

    NewsService.requestNewsLabel((success, result) {
      ToastUtils.hideLoading();

      if (success) {
        if (result.isNotEmpty) {
          for (int i = 0; i < result.length; i++) {
            NewsLabelModel model = result[i];
            if (model.name == "微视频") {
            } else {
              HomeTabbarItemWidget item = HomeTabbarItemWidget(
                tabName: model.name,
                index: i,
              );
              _dataArr.add(item);
            }
          }

          // 初始化
          _tabController = TabController(length: _dataArr.length, vsync: this);
          _pageController = PageController();

          _layoutState = LoadStatusType.success;
        } else {
          _layoutState = LoadStatusType.empty;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }
      setState(() {});
    });
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_dataArr.isEmpty) {
      return const SizedBox();
    }
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
                      tabs: _dataArr),
                ),
              ),
              Expanded(
                  child: PageView.builder(
                      key: const Key('pageView'),
                      itemCount: _dataArr.length,
                      onPageChanged: _onPageChange,
                      controller: _pageController,
                      itemBuilder: (_, int index) {
                        return const NewsChildPage();
                      }))
            ],
          ),
        ));
  }
}
