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
import 'package:wzty/modules/match/entity/detail/match_status_bb_score_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_tech_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';
import 'package:wzty/modules/match/page/status/match_status_bb_live_page.dart';
import 'package:wzty/modules/match/page/status/match_status_bb_tech_page.dart';
import 'package:wzty/modules/match/service/match_detail_status_service.dart';
import 'package:wzty/modules/match/widget/status/match_status_bb_data_widget.dart';
import 'package:wzty/modules/match/widget/status/match_status_bb_score_widget.dart';
import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailBBStatusPage extends StatefulWidget {
  final int matchId;

  final MatchDetailModel detailModel;

  const MatchDetailBBStatusPage(
      {super.key, required this.matchId, required this.detailModel});

  @override
  State createState() => _MatchDetailBBStatusPageState();
}

class _MatchDetailBBStatusPageState
    extends KeepAliveWidgetState<MatchDetailBBStatusPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();

  final List<Widget> _tabs = [
    const MatchStatusTabbarItemWidget(
      tabName: '技术统计',
      index: 0,
    ),
    const MatchStatusTabbarItemWidget(
      tabName: '文字直播',
      index: 1,
    ),
  ];

  LoadStatusType _layoutState = LoadStatusType.loading;

  MatchStatusBBScoreModel? scoreModel;
  MatchStatusBBTechModel? techModel;
  MatchStatusBBLiveLocalModel? liveModel;
  MatchStatusBBLiveLocalModel? live2Model;

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

    Future score = MatchDetailStatusService.requestBBScoreData(widget.matchId,
        (success, result) {
      scoreModel = result;
    });

    Future tech = MatchDetailStatusService.requestBBTechData(widget.matchId,
        (success, result) {
      techModel = result;
    });

    Future live = MatchDetailStatusService.requestLiveData(
        SportType.football, widget.matchId, (success, result) {
      liveModel = _processFBLiveData(result);
    });

    Future.wait([score, tech, live]).then((value) {
      if (liveModel == null) {
        MatchDetailStatusService.requestLive2Data(widget.matchId,
            (success, result) {
          live2Model = _processFBLiveData2(result);
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
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              Widget web =
                  matchStatus == MatchStatus.going && model.trendAnim.isNotEmpty
                      ? SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            height: 62, //110
                            child: WZWebviewPage(urlStr: model.trendAnim),
                          ),
                        )
                      : const SliverToBoxAdapter(child: SizedBox());

              return [
                web,
                SliverToBoxAdapter(
                  child: MatchStatusBBScoreWidget(
                      detailModel: widget.detailModel, scoreModel: scoreModel!),
                ),
                SliverToBoxAdapter(
                    child: const SizedBox(height: 10, width: double.infinity)
                        .colored(ColorUtils.gray248)),
                SliverToBoxAdapter(
                    child: MatchStatusBBDataWidget(techModel: techModel!)),
                SliverToBoxAdapter(
                    child: const SizedBox(height: 10, width: double.infinity)
                        .colored(ColorUtils.gray248)),
                SliverToBoxAdapter(
                  child: Container(
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
                        labelPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        tabs: _tabs),
                  ),
                ),
              ];
            },
            body: PageView.builder(
                itemCount: _tabs.length,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, int index) {
                  if (index == 0) {
                    return MatchStatusBBTechPage(
                        detailModel: widget.detailModel, techModel: techModel);
                  }
                  return MatchStatusBBLivePage(
                      liveModel: liveModel, live2Model: live2Model);
                })));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }

  // -------------------------------------------------------------

  MatchStatusBBLiveLocalModel? _processFBLiveData(
      List<MatchStatusFBLiveModel> dataArr) {
    if (dataArr.isEmpty) {
      return null;
    }

    List<String> titleArr = [];
    List<List<MatchStatusFBLiveModel>> modelArr2 = [];

    int period = dataArr[0].period;
    List<MatchStatusFBLiveModel> modelArr = [];

    for (MatchStatusFBLiveModel model in dataArr) {
      if (period == model.period) {
        modelArr.add(model);
      } else {
        titleArr.add(AppBusinessUtils.obtainMatchLiveTitle(period));
        modelArr2.add(modelArr);

        period = model.period;
        modelArr = [];

        modelArr.add(model);
      }
    }

    // 结束后 最后一个数组
    modelArr2.add(modelArr);
    titleArr.add(AppBusinessUtils.obtainMatchLiveTitle(period));

    return MatchStatusBBLiveLocalModel(
        titleArr: titleArr, modelArr2: modelArr2);
  }

  MatchStatusBBLiveLocalModel? _processFBLiveData2(
      List<MatchStatusFBEventModel> dataArr) {
    if (dataArr.isEmpty) {
      return null;
    }

    for (MatchStatusFBEventModel model in dataArr) {
      if (model.statusName.contains("一")) {
        model.statusCode = 1;
      } else if (model.statusName.contains("二")) {
        model.statusCode = 2;
      } else if (model.statusName.contains("三")) {
        model.statusCode = 3;
      } else if (model.statusName.contains("四")) {
        model.statusCode = 4;
      }
    }

    dataArr.sort((a, b) => a.statusCode.compareTo(b.statusCode));

    List<String> titleArr = [];
    List<List<MatchStatusFBEventModel>> modelArr2 = [];

    String statusName = dataArr[0].statusName;
    List<MatchStatusFBEventModel> modelArr = [];

    for (MatchStatusFBEventModel model in dataArr) {
      if (model.statusName.isEmpty) {
        continue;
      }
      if (statusName == model.statusName) {
        modelArr.add(model);
      } else {
        titleArr.add(statusName);
        modelArr2.add(modelArr);

        statusName = model.statusName;
        modelArr = [];

        modelArr.add(model);
      }
    }

    // 结束后 最后一个数组
    modelArr2.add(modelArr);
    titleArr.add(statusName);

    return MatchStatusBBLiveLocalModel(
        titleArr: titleArr, modelArr2: modelArr2);
  }
}
