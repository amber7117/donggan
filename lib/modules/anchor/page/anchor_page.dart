import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/home_search_widget.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/home_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/anchor/entity/anchor_category_entity.dart';
import 'package:wzty/modules/anchor/page/anchor_child_hot_page.dart';
import 'package:wzty/modules/anchor/page/anchor_child_page.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

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

  LoadStatusType _layoutState = LoadStatusType.loading;

  final List<AnchorCategoryModel> _labelArr = [
    AnchorCategoryModel.empty(),
  ];
  final List<Widget> _tabs = [
    const HomeTabbarItemWidget(
      tabName: '推荐',
      index: 0,
    )
  ];

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

    AnchorService.requestCategoryInfo((success, result) {
      ToastUtils.hideLoading();

      if (success) {
        if (result.isNotEmpty) {
          int i = 1;
          for (AnchorCategoryModel model in result) {
            HomeTabbarItemWidget item = HomeTabbarItemWidget(
              tabName: model.liveGroupName,
              index: i,
            );
            _labelArr.add(model);
            _tabs.add(item);
            i++;
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

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            state: _layoutState, successWidget: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_tabs.length == 1) {
      return const SizedBox();
    }

    return ChangeNotifierProvider<TabProvider>(
        create: (context2) => _tabProvider,
        child: Column(
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
                      type: HomeSearchType.live,
                      searchTap: () {
                        Routes.present(context, Routes.search);
                      },
                      rightTap: () {
                        if (!UserManager.instance.isLogin()) {
                          Routes.goLoginPage(context);
                          return;
                        }
                        Routes.push(context, Routes.meFollow);
                      }),
                  const SizedBox(height: 3.0),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: TabBar(
                        onTap: (index) {
                          if (!mounted) return;
                          _pageController.jumpToPage(index);
                        },
                        isScrollable: true,
                        controller: _tabController,
                        dividerHeight: 0.0,
                        indicator: const BoxDecoration(),
                        labelPadding: const EdgeInsets.only(left: 2, right: 2),
                        tabAlignment: TabAlignment.start,
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
                      AnchorCategoryModel model = _labelArr[index];
                      if (model.liveGroupId == 0) {
                        return const AnchorChildHotPage();
                      } else {
                        return AnchorChildPage(model: model);
                      }
                    }))
          ],
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
