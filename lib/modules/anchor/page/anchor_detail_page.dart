import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/tabbar/match_detail_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_calendar_page.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_playback_page.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_user_info_widget.dart';
import 'package:wzty/modules/chat/chat_page.dart';
import 'package:wzty/modules/match/provider/match_detail_data_provider.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_video_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_web_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

const double _headHeight = 212.0;

class AnchorDetailPage extends StatefulWidget {
  final int anchorId;

  const AnchorDetailPage({super.key, required this.anchorId});

  @override
  State createState() => _AnchorDetailPageState();
}

class _AnchorDetailPageState extends KeepAliveLifeWidgetState<AnchorDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();
  final MatchDetailDataProvider _dataProvider = MatchDetailDataProvider();

  final List<Widget> _tabs = [
    const MatchDetailTabbarItemWidget(
      tabName: '聊球',
      index: 0,
    ),
    const MatchDetailTabbarItemWidget(
      tabName: '预告',
      index: 1,
    ),
    const MatchDetailTabbarItemWidget(
      tabName: '回放',
      index: 2,
    ),
  ];

  LoadStatusType _layoutState = LoadStatusType.loading;
  AnchorDetailModel? _model;
  AnchorDetailModel? _playInfo;

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

    Future basic = AnchorService.requestDetailBasicInfo(widget.anchorId,
        (success, result) {
      _model = result;
    });
    Future play =
        AnchorService.requestDetailPlayInfo(widget.anchorId, (success, result) {
      _playInfo = result;
    });

    Future.wait([basic, play]).then((value) {
      ToastUtils.hideLoading();

      if (_model != null && _playInfo != null) {
        _model!.updatePlayDataByModel(_playInfo!);

        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.failure;
      }

      setState(() {});
    });
  }

  String _attemptPlayVideo() {
    if (_model == null) {
      return "";
    }

    AnchorDetailModel model = _model!;

    if (model.playAddr.isEmpty) {
      return "";
    }

    if (ConfigManager.instance.videoIsBlock(model.leagueId)) {
      return "";
    }

    String videoUrl = "";
    if (model.isRobot.isTrue()) {
      videoUrl = _obtainVideoUrl(model.playAddr, "");
    } else {
      videoUrl = _obtainVideoUrl(model.playAddr, "sd");
    }
    return videoUrl;
  }

  String _obtainVideoUrl(Map<String, String> addrDic, String prefix) {
    String videoUrl = "";
    String key1 = "";
    String key2 = "";
    String key3 = "";

    if (prefix.isNotEmpty) {
      key1 = "${prefix}_flv";
      key2 = "${prefix}_m3u8";
      key3 = "${prefix}_rtmp";
    } else {
      key1 = "flv";
      key2 = "m3u8";
      key3 = "rtmp";
    }

    if (addrDic.containsKey(key1)) {
      videoUrl = addrDic[key1]!;
    } else if (addrDic.containsKey(key2)) {
      videoUrl = addrDic[key2]!;
    } else if (addrDic.containsKey(key3)) {
      videoUrl = addrDic[key3]!;
    }

    return videoUrl;
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context2) => _tabProvider),
          ChangeNotifierProvider(create: (context2) => _dataProvider),
        ],
        child: Column(
          children: [
            Consumer<MatchDetailDataProvider>(builder: (context, provider, child) {
              String videoUrl = _attemptPlayVideo();
              if (videoUrl.isNotEmpty) {
                return MatchDetailHeadVideoWidget(
                    height: _headHeight, urlStr: videoUrl);
              } else if (_model!.animUrl.isNotEmpty) {
                return MatchDetailHeadWebWidget(
                    height: _headHeight, urlStr: _model!.animUrl);
              } else {
                 return SizedBox(
                    width: double.infinity,
                    height: _headHeight + ScreenUtil().statusBarHeight);
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
                        return ChatPage(
                            roomId: _model!.roomId.toString(),
                            chatRoomId: _model!.chatId);
                      } else if (index == 1) {
                        return AnchorDetailCalendarPage(
                            anchorId: widget.anchorId);
                      } else {
                        return AnchorDetailPlaybackPage(
                            anchorId: widget.anchorId,
                            nickName: _model!.nickname);
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
