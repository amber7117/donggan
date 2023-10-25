import 'package:flutter/material.dart';
import 'package:wzty/common/webview/wz_webview_page.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/match_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/provider/match_detail_data_provider.dart';
import 'package:wzty/modules/match/widget/detail/match_status_data_widget.dart';
import 'package:wzty/utils/color_utils.dart';

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
    const MatchTabbarItemWidget(
      tabName: '关键事件',
      index: 0,
    ),
    const MatchTabbarItemWidget(
      tabName: '技术统计',
      index: 1,
    ),
    const MatchTabbarItemWidget(
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
    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.yellow,
            width: double.infinity,
            height: 110,
            child: WZWebviewPage(urlStr: model.trendAnim),
          ),
          MatchStatusDataWidget(),
          Container(
            height: 200,
          )
        ],
      ),
    );
  }
}
