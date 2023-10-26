import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/webview/wz_webview_page.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/match_status_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';
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

  MatchStatusFBTechModel? techModel;
  List<MatchStatusFBEventModel> eventModelArr = [];
  List<MatchStatusFBLiveModel> liveModelArr = [];
  List<MatchStatusFBEventModel> live2ModelArr = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

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

    Future tech = MatchDetailStatusService.requestFbTechData(widget.matchId,
        (success, result) {
      techModel = result;
    });
    Future event = MatchDetailStatusService.requestFbEventData(widget.matchId,
        (success, result) {
      if (result.isNotEmpty) {
        var tmpArr = _processFBEventData(result);
        eventModelArr = tmpArr;
      }
    });
    Future live = MatchDetailStatusService.requestLiveData(
        widget.matchId, SportType.football, (success, result) {
      if (result.isNotEmpty) {
        var tmpArr = _processFBLiveData(result).cast<MatchStatusFBLiveModel>();
        liveModelArr = tmpArr;
      }
    });

    Future.wait([tech, event, live]).then((value) {
      if (liveModelArr.isEmpty) {
        MatchDetailStatusService.requestLive2Data(widget.matchId,
            (success, result) {
          if (result.isNotEmpty) {
            var tmpArr = _processFBLiveData(result, isLiveModel: false)
                .cast<MatchStatusFBEventModel>();
            live2ModelArr = tmpArr;
          }
          ToastUtils.hideLoading();
          _handleResultData();
        });
      } else {
        ToastUtils.hideLoading();
        _handleResultData();
      }
    });
  }

  _handleResultData() {
    // if (_model != null && _playInfo != null) {

    _layoutState = LoadStatusType.success;
    // } else {
    //   _layoutState = LoadStatusType.failure;
    // }

    setState(() {});
  }

  // -------------------------------------------------------------

  @override
  Widget buildWidget(BuildContext context) {
    return _buildChild(context);
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
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
                          return MatchStatusEventPage(
                              eventModelArr: eventModelArr);
                        } else if (index == 1) {
                          return MatchStatusTechPage(techModel: techModel);
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

  // -------------------------------------------------------------

  List<MatchStatusFBEventModel> _processFBEventData(
      List<MatchStatusFBEventModel> dataArr) {
    List<MatchStatusFBEventModel> retArr = [];

    MatchStatusFBEventModel hintModelShang =
        MatchStatusFBEventModel.fromJson({});
    MatchStatusFBEventModel hintModelXia = MatchStatusFBEventModel.fromJson({});

    MatchDetailModel matchModel = widget.detailModel;

    for (MatchStatusFBEventModel model in dataArr) {
      if (model.team == 0) {
        if (model.typeId == 13 || model.content.contains("中场休息")) {
          hintModelShang.content =
              "上半场 ${matchModel.hostHalfScore}-${matchModel.guestHalfScore}";
          hintModelShang.team = 0;
          hintModelShang.stage = 1;

          retArr.add(hintModelShang);
        }
      } else {
        retArr.add(model);
      }
    }

    if (hintModelShang.content.isNotEmpty) {
      hintModelXia.content =
          "下半场 ${matchModel.hostTeamScore}-${matchModel.guestTeamScore}";
      hintModelXia.team = 0;
      hintModelXia.stage = 1;

      retArr.insert(0, hintModelXia);
    } else {
      hintModelShang.content =
          "上半场 ${matchModel.hostHalfScore}-${matchModel.guestHalfScore}";
      hintModelShang.team = 0;
      hintModelShang.stage = -1;

      retArr.insert(0, hintModelXia);
    }

    return retArr;
  }

  List<dynamic> _processFBLiveData(List<dynamic> dataArr,
      {bool isLiveModel = true}) {
    if (dataArr.isEmpty) {
      return dataArr;
    }

    List<dynamic> retArr = [];

    MatchDetailModel matchModel = widget.detailModel;

    MatchStatus matchStatus =
        matchStatusFromServerValue(matchModel.matchStatus);

    if (matchStatus == MatchStatus.finished) {
      if (isLiveModel) {
        MatchStatusFBLiveModel model = MatchStatusFBLiveModel.fromJson({});
        model.cnText = "结束";
        model.typeId = 2003;
        retArr.add(model);
      } else {
        MatchStatusFBEventModel model = MatchStatusFBEventModel.fromJson({});
        model.content = "结束";
        model.typeId = 2003;
        retArr.add(model);
      }
    } else {
      if (isLiveModel) {
        MatchStatusFBLiveModel model = MatchStatusFBLiveModel.fromJson({});
        model.cnText = "进行中";
        model.typeId = 2002;
        retArr.add(model);
      } else {
        MatchStatusFBEventModel model = MatchStatusFBEventModel.fromJson({});
        model.content = "进行中";
        model.typeId = 2002;
        retArr.add(model);
      }
    }

    retArr.addAll(dataArr);

    if (isLiveModel) {
      MatchStatusFBLiveModel model = MatchStatusFBLiveModel.fromJson({});
      model.cnText = "开始";
      model.typeId = 2001;
      retArr.add(model);
    } else {
      MatchStatusFBEventModel model = MatchStatusFBEventModel.fromJson({});
      model.content = "开始";
      model.typeId = 2001;
      retArr.add(model);
    }

    return retArr;
  }
}
