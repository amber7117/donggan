import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
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
import 'package:wzty/modules/match/widget/status/match_status_fb_data_widget.dart';
import 'package:wzty/modules/match/page/status/match_status_fb_event_page.dart';
import 'package:wzty/modules/match/page/status/match_status_fb_live_page.dart';
import 'package:wzty/modules/match/page/status/match_status_fb_tech_page.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailFBStatusPage extends StatefulWidget {
  final int matchId;

  final MatchDetailModel detailModel;

  const MatchDetailFBStatusPage(
      {super.key, required this.matchId, required this.detailModel});

  @override
  State createState() => _MatchDetailFBStatusPageState();
}

class _MatchDetailFBStatusPageState
    extends KeepAliveWidgetState<MatchDetailFBStatusPage>
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

  LoadStatusType _layoutState = LoadStatusType.loading;

  MatchStatusFBTechModel? techModel;
  List<MatchStatusFBEventModel> eventModelArr = [];
  List<MatchStatusFBLiveModel> liveModelArr = [];
  List<MatchStatusFBEventModel> live2ModelArr = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    MatchDetailModel model = widget.detailModel;
    MatchStatus matchStatus = matchStatusFromServerValue(model.matchStatus);
    if (matchStatus == MatchStatus.uncoming) {
      _layoutState = LoadStatusType.empty;
      setState(() {});
    } else {
      _requestData();
    }
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
        SportType.football, widget.matchId, (success, result) {
      if (result.isNotEmpty) {
        liveModelArr =
            _processFBLiveData(result).cast<MatchStatusFBLiveModel>();
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
    _layoutState = LoadStatusType.success;
    setState(() {});
  }

  // -------------------------------------------------------------

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    if (_layoutState != LoadStatusType.success) {
      return const SizedBox();
    }

    MatchDetailModel model = widget.detailModel;
    MatchStatus matchStatus = matchStatusFromServerValue(model.matchStatus);

    return ChangeNotifierProvider<TabProvider>(
        create: (context2) => _tabProvider,
        child: Column(
          children: [
            matchStatus == MatchStatus.going && model.trendAnim.isNotEmpty
                ? SizedBox(
                    width: double.infinity,
                    height: 62, //110
                    child: WZWebviewPage(urlStr: model.trendAnim),
                  )
                : const SizedBox(),
            const SizedBox(height: 10, width: double.infinity)
                .colored(ColorUtils.gray248),
            MatchStatusFBDataWidget(model: techModel),
            const SizedBox(height: 10, width: double.infinity)
                .colored(ColorUtils.gray248),
            Container(
              width: double.infinity,
              height: 66,
              alignment: Alignment.center,
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
            Expanded(
                child: PageView.builder(
                    itemCount: _tabs.length,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) {
                      if (index == 0) {
                        return MatchStatusFBEventPage(
                            detailModel: widget.detailModel,
                            eventModelArr: eventModelArr);
                      } else if (index == 1) {
                        return MatchStatusFBTechPage(
                            detailModel: widget.detailModel,
                            techModel: techModel);
                      }
                      return MatchStatusFBLivePage(
                          liveModelArr: liveModelArr,
                          live2ModelArr: live2ModelArr);
                    }))
          ],
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

    MatchStatusFBEventModel? idxModel;

    for (MatchStatusFBEventModel model in dataArr) {
      if (model.team == 0) {
        if (model.typeId == 13 || model.content.contains("中场休息")) {
          hintModelShang.content =
              "上半场 ${matchModel.hostHalfScore}-${matchModel.guestHalfScore}";
          hintModelShang.team = 0;
          hintModelShang.stage = 1;

          retArr.add(hintModelShang);

          if (idxModel != null) {
            idxModel.idx = 1; //用来做UI圆角
          }
        }
      } else {
        idxModel = model;
        retArr.add(model);
      }
    }

    if (idxModel != null) {
      idxModel.idx = 1; //用来做UI圆角
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
