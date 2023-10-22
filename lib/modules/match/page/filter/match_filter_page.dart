import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/match_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/match/entity/match_filter_entity.dart';
import 'package:wzty/modules/match/manager/match_filter_manager.dart';
import 'package:wzty/modules/match/page/filter/match_filter_all_page.dart';
import 'package:wzty/modules/match/page/filter/match_filter_hot_page.dart';
import 'package:wzty/modules/match/provider/match_detail_data_provider.dart';
import 'package:wzty/modules/match/service/match_filter_service.dart';
import 'package:wzty/modules/match/widget/filter/match_filter_bottom_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchFilterPage extends StatefulWidget {
  final SportType sportType;
  final MatchStatus matchStatus;
  final String dateStr;

  const MatchFilterPage({
    super.key,
    required this.sportType,
    required this.matchStatus,
    required this.dateStr,
  });

  @override
  State createState() => _MatchFilterPageState();
}

class _MatchFilterPageState extends State<MatchFilterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();
  final MatchDetailDataProvider _detailProvider = MatchDetailDataProvider();

  final GlobalKey<MatchFilterAllPageState> _allPageKey = GlobalKey();
  final GlobalKey<MatchFilterHotPageState> _hotPageKey = GlobalKey();
  final GlobalKey<MatchFilterBottomWidgetState> _bottomWidgetKey = GlobalKey();

  final List<Widget> _tabs = [
    const MatchTabbarItemWidget(
      tabName: "全部",
      index: 0,
      tabWidth: 60.0,
      tabHeight: 44.0,
    ),
    const MatchTabbarItemWidget(
      tabName: "热门",
      index: 1,
      tabWidth: 60.0,
      tabHeight: 44.0,
    ),
  ];
  LoadStatusType _layoutState = LoadStatusType.loading;
  MatchFilterModel? _allData;
  MatchFilterModel? _hotData;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _tabController = TabController(length: _tabs.length, vsync: this);

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

    Future all = MatchFilterService.requestAllData(
        MatchFilterType.footballAll, widget.matchStatus, widget.dateStr,
        (success, result) {
      if (result != null) {
        _allData = _processServerData(result, true);
      }
    });
    Future hot = MatchFilterService.requestHotData(MatchFilterType.footballHot,
        (success, result) {
      if (result != null) {
        _hotData = _processServerData(result, false);
      }
    });

    Future.wait([all, hot]).then((value) {
      ToastUtils.hideLoading();

      if (_allData != null && _hotData != null) {
        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.failure;
      }

      setState(() {});

      Future.delayed(const Duration(seconds: 1), () {
        _updateBottomViewUI();
      });
    });
  }

  _processServerData(MatchFilterModel data, bool isAll) {
    MatchFilterType filterType = _getFilterType(isAll);

    List<int> leagueIdArr = MatchFilterManager.instance
        .obtainFilterData(widget.sportType, filterType, widget.matchStatus);
    if (leagueIdArr.isEmpty) {
      return data;
    }

    if (isAll) {
      List<List<MatchFilterItemModel>> modelArrArr = data.moderArrArr;

      for (List<MatchFilterItemModel> modelArr in modelArrArr) {
        for (MatchFilterItemModel model in modelArr) {
          if (leagueIdArr.contains(model.id)) {
            model.noSelect = false;
          } else {
            model.noSelect = true;
          }
        }
      }
    } else {
      List<MatchFilterItemModel> modelArr = data.hotArr;

      for (MatchFilterItemModel model in modelArr) {
        if (leagueIdArr.contains(model.id)) {
          model.noSelect = false;
        } else {
          model.noSelect = true;
        }
      }
    }

    return data;
  }

  _getFilterType(bool isAll) {
    MatchFilterType filterType = MatchFilterType.basketballAll;
    if (widget.sportType == SportType.football) {
      if (isAll) {
        filterType = MatchFilterType.footballAll;
      } else {
        filterType = MatchFilterType.footballHot;
      }
    } else {
      filterType = MatchFilterType.basketballAll;
    }
    return filterType;
  }

  _handleBottomEvent(MatchFilterBottomEvent event) {
    if (event == MatchFilterBottomEvent.selectAll) {
      if (_tabProvider.index == 0) {
        _allPageKey.currentState?.selectAllMatch();
      } else {
        _hotPageKey.currentState?.selectAllMatch();
      }
      _updateBottomViewUI();
    } else if (event == MatchFilterBottomEvent.selectOther) {
      if (_tabProvider.index == 0) {
        _allPageKey.currentState?.selectOtherMatch();
      } else {
        _hotPageKey.currentState?.selectOtherMatch();
      }
      _updateBottomViewUI();
    } else {
      _obtainFilterData();
    }
  }

  _updateBottomViewUI() {
    bool existNoSelect = false;
    int allCount = 0;
    int selectCount = 0;

    if (_tabProvider.index == 0) {
      for (List<MatchFilterItemModel> modelArr in _allData!.moderArrArr) {
        for (MatchFilterItemModel model in modelArr) {
          if (model.noSelect) {
            existNoSelect = true;
          } else {
            selectCount += model.matchCount;
          }
          allCount += model.matchCount;
        }
      }
    } else {
      for (MatchFilterItemModel model in _hotData!.hotArr) {
        if (model.noSelect) {
          existNoSelect = true;
        } else {
          selectCount += model.matchCount;
        }
        allCount += model.matchCount;
      }
    }

    if (existNoSelect) {
      _bottomWidgetKey.currentState?.updateUI(
          canSelectAll: true,
          canSelectOther: true,
          selectCount: allCount - selectCount);
    } else {
      _bottomWidgetKey.currentState?.updateUI(
          canSelectAll: false,
          canSelectOther: true,
          selectCount: allCount - selectCount);
    }
  }

  _obtainFilterData() {
    bool isSelectAll = true;
    List<int> leagueIdArr = [];

    if (_tabProvider.index == 0) {
      for (List<MatchFilterItemModel> modelArr in _allData!.moderArrArr) {
        for (MatchFilterItemModel model in modelArr) {
          if (model.noSelect) {
            isSelectAll = false;
          } else {
            leagueIdArr.add(model.id);
          }
        }
      }
    } else {
      for (MatchFilterItemModel model in _hotData!.hotArr) {
        if (model.noSelect) {
          isSelectAll = false;
        } else {
          leagueIdArr.add(model.id);
        }
      }
    }

    MatchFilterType filterType = _getFilterType(_tabProvider.index == 0);

    if (isSelectAll) {
      leagueIdArr = [];
    }

    MatchFilterManager.instance.updateFilterData(
        widget.sportType, filterType, widget.matchStatus, leagueIdArr);

    // callback?.call();

    Routes.goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(titleText: "足球赛事"),
      body: LoadStateWidget(
          state: _layoutState, successWidget: _buildChild(context)),
    );
  }

  _buildChild(BuildContext context) {
    if (_allData == null || _hotData == null) {
      return const SizedBox();
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context2) => _tabProvider),
          ChangeNotifierProvider(create: (context2) => _detailProvider),
        ],
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 240,
                child: TabBar(
                    onTap: (index) {
                      if (!mounted) return;
                      _pageController.jumpToPage(index);
                    },
                    isScrollable: true,
                    controller: _tabController,
                    indicator: const BoxDecoration(),
                    labelPadding: const EdgeInsets.only(left: 30, right: 30),
                    tabs: _tabs),
              ),
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
                        return MatchFilterAllPage(
                            key: _allPageKey,
                            model: _allData!,
                            callback: () {
                              _updateBottomViewUI();
                            });
                      } else {
                        return MatchFilterHotPage(
                            key: _hotPageKey,
                            model: _hotData!,
                            callback: () {
                              _updateBottomViewUI();
                            });
                      }
                    })),
            MatchFilterBottomWidget(
                key: _bottomWidgetKey,
                callback: (data) {
                  _handleBottomEvent(data);
                }),
            SizedBox(height: ScreenUtil().bottomBarHeight),
          ],
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
