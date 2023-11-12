import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/match_detail_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/entity/anchor_video_entity.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_calendar_page.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_playback_page.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_head_video_widget.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_user_info_widget.dart';
import 'package:wzty/modules/match/provider/match_detail_data_provider.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_web_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';
import 'package:wzty/utils/wz_string_utils.dart';

class LivePlaybackPage extends StatefulWidget {
  final AnchorVideoModel videoModel;

  const LivePlaybackPage({super.key, required this.videoModel});

  @override
  State createState() => _LivePlaybackPageState();
}

class _LivePlaybackPageState extends KeepAliveLifeWidgetState<LivePlaybackPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();
  final MatchDetailDataProvider _dataProvider = MatchDetailDataProvider();

  final List<Widget> _tabs = [
    const MatchDetailTabbarItemWidget(
      tabName: '预告',
      index: 0,
    ),
    const MatchDetailTabbarItemWidget(
      tabName: '回放',
      index: 1,
    ),
  ];

  LoadStatusType _layoutState = LoadStatusType.loading;
  AnchorDetailModel? _model;
  AnchorRecordModel? _playInfo;

  final String playerId = WZStringUtils.generateRandomString(8);

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

  @override
  void onPageResume() {
    super.onPageResume();

    if (_model != null) {
      eventBusManager.emit(PlayerStatusEvent(playerId: playerId, pause: false));
    }
  }

  @override
  void onPagePaused() {
    super.onPagePaused();

    if (_model != null) {
      eventBusManager.emit(PlayerStatusEvent(playerId: playerId, pause: true));
    }
  }

  _requestData() {
    AnchorVideoModel model = widget.videoModel;

    ToastUtils.showLoading();

    Future basic =
        AnchorService.requestDetailBasicInfo(model.anchorId, (success, result) {
      _model = result;
    });
    Future play = AnchorService.requestPlaybackInfo(
        model.anchorId, model.roomRecordId, (success, result) {
      _playInfo = result;
    });

    Future.wait([basic, play]).then((value) {
      ToastUtils.hideLoading();

      if (_model != null && _playInfo != null) {
        _model!.updatePlaybackDataByModel(_playInfo!);

        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.empty;
      }

      setState(() {});
    });
  }

  String _attempPlayPlayback() {
    late AnchorDetailModel model;
    if (_model == null) {
      return "";
    }

    model = _model!;

    if (model.recordAddr.isEmpty) {
      return "";
    }

    if (ConfigManager.instance.videoIsBlock(model.leagueId)) {
      return "";
    }

    return model.recordAddr["m3u8"] ?? "";
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }

    AnchorVideoModel model = widget.videoModel;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context2) => _tabProvider),
          ChangeNotifierProvider(create: (context2) => _dataProvider),
        ],
        child: Column(
          children: [
            Consumer<MatchDetailDataProvider>(
                builder: (context, provider, child) {
              String videoUrl = _attempPlayPlayback();
              if (videoUrl.isNotEmpty) {
                return AnchorDetailHeadVideoWidget(
                    height: videoHeight(),
                    urlStr: videoUrl,
                    isAnchor: false,
                    playerId: playerId);
              } else if (_model!.animUrl.isNotEmpty) {
                return MatchDetailHeadWebWidget(
                    height: videoHeight(), urlStr: _model!.animUrl);
              } else {
                return SizedBox(
                    width: double.infinity, height: videoStatusBarHeight());
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ScreenUtil().screenWidth * 0.5,
                  child: TabBar(
                      onTap: (index) {
                        if (!mounted) return;
                        _pageController.jumpToPage(index);
                      },
                      isScrollable: true,
                      controller: _tabController,
                      indicator: const BoxDecoration(),
                      labelPadding: const EdgeInsets.only(right: 4),
                      tabs: _tabs),
                ),
                AnchorDetailUserInfoWidget(model: _model!),
              ],
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
                        return AnchorDetailCalendarPage(
                            anchorId: model.anchorId);
                      } else {
                        return AnchorDetailPlaybackPage(
                            anchorId: model.anchorId,
                            nickName: _model!.nickname,
                            isDetailPage: false);
                      }
                    }))
          ],
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }
}
