import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/webview/wz_webview_page.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/match_status_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/provider/match_detail_data_provider.dart';
import 'package:wzty/modules/match/service/match_detail_status_service.dart';
import 'package:wzty/modules/match/widget/detail/match_status_data_widget.dart';
import 'package:wzty/modules/match/page/match_status_event_page.dart';
import 'package:wzty/modules/match/page/match_status_live_page.dart';
import 'package:wzty/modules/match/page/match_status_tech_page.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailStatusPage extends StatefulWidget {
  final int matchId;

  final MatchDetailModel detailModel;

  const MatchDetailStatusPage(
      {super.key, required this.matchId, required this.detailModel});

  @override
  State createState() => _MatchDetailStatusPageState();
}

class _MatchDetailStatusPageState
    extends KeepAliveWidgetState<MatchDetailStatusPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();
  final MatchDetailDataProvider _detailProvider = MatchDetailDataProvider();

  final List<Widget> _tabs = [
    const MatchStatusTabbarItemWidget(
      tabName: '关键事件',
      index: 0,
    ),
    const MatchStatusTabbarItemWidget(
      tabName: '技术统计',
      index: 1,
    ),
    const MatchStatusTabbarItemWidget(
      tabName: '文字直播',
      index: 2,
    ),
  ];

  LoadStatusType _layoutState = LoadStatusType.success;

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

  _requestData() {
    ToastUtils.showLoading();

    Future tech = MatchDetailStatusService.requestFbTechData(
        widget.matchId, (success, result) {});
    Future event = MatchDetailStatusService.requestFbEventData(
        widget.matchId, (success, result) {});
    Future live = MatchDetailStatusService.requestLiveData(
        widget.matchId, SportType.football, (success, result) {});
    Future live2 = MatchDetailStatusService.requestLive2Data(
        widget.matchId, (success, result) {});

    Future.wait([tech, event, live, live2]).then((value) {
      ToastUtils.hideLoading();

      // if (_model != null && _playInfo != null) {

      _layoutState = LoadStatusType.success;
      // } else {
      //   _layoutState = LoadStatusType.failure;
      // }

      setState(() {});
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return _buildChild(context);
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    MatchDetailModel model = widget.detailModel;
    return ChangeNotifierProvider<TabProvider>(
        create: (context2) => _tabProvider,
        child: Expanded(
          child: Column(
            children: [
              Container(
                color: Colors.yellow,
                width: double.infinity,
                height: 110,
                child: WZWebviewPage(urlStr: model.trendAnim),
              ),
              MatchStatusDataWidget(),
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
                          return MatchStatusEventPage();
                        } else if (index == 1) {
                          return MatchStatusTechPage();
                        }
                        return MatchStatusLivePage();
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
