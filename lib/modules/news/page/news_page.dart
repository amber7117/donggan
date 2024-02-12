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


class _NewsPageState extends KeepAliveWidgetState
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();

  LoadStatusType _layoutState = LoadStatusType.loading;
  final List<NewsLabelModel> _labelArr = [];
  final List<HomeTabbarItemWidget> _tabs = [];

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
          int i = 0;
          for (NewsLabelModel model in result) {
            if (model.name != "微视频") {
              HomeTabbarItemWidget item = HomeTabbarItemWidget(
                tabName: model.name,
                index: i,
              );
              _labelArr.add(model);
              _tabs.add(item);
              i++;
            }
          }

          // 初始化
          _tabController = TabController(length: _tabs.length, vsync: this);
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
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      body: LoadStateWidget(
        state: _layoutState,
        successWidget: _buildChild(context))
    );
  }

  _buildChild(BuildContext context) {
    if (_tabs.isEmpty) {
      return const SizedBox();
    }
    return ChangeNotifierProvider<TabProvider>(
        create: (context2) => _tabProvider,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: ScreenUtil().statusBarHeight + 65.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: JhImageUtils.getAssetImage("common/bgHomeTop"),
                    fit: BoxFit.fitWidth),
              ),
              child: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: ScreenUtil().statusBarHeight, left: 12, right: 12),
                child: TabBar(
                    onTap: (index) {
                      if (!mounted) return;
                      _pageController.jumpToPage(index);
                    },
                    isScrollable: true,
                    controller: _tabController,
                    indicator: const BoxDecoration(),
                    labelPadding: const EdgeInsets.only(left: 2, right: 2),
                    tabAlignment: TabAlignment.start,
                    tabs: _tabs),
              ),
            ),
            Expanded(
                child: PageView.builder(
                    itemCount: _tabs.length,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) {
                      NewsLabelModel model = _labelArr[index];
                      return NewsChildPage(categoryId: model.categoryId);
                    }))
          ],
        ));
  }
}
