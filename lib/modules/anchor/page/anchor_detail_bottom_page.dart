import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/match_detail_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_calendar_page.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_playback_page.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_user_info_widget.dart';
import 'package:wzty/modules/chat/chat_page.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class AnchorDetailBottomPage extends StatefulWidget {
  final int anchorId;
  final AnchorDetailModel model;
  final VoidCallback callback;

  const AnchorDetailBottomPage(
      {super.key,
      required this.anchorId,
      required this.model,
      required this.callback});

  @override
  State createState() => AnchorDetailBottomPageState();
}

class AnchorDetailBottomPageState extends State<AnchorDetailBottomPage>
    with SingleTickerProviderStateMixin {
  showDataBtn() {
    _showDataBtn = true;
    _dataBtnSetter(() {});
  }

  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();

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

  late StateSetter _dataBtnSetter;
  bool _showDataBtn = false;

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
  Widget build(BuildContext context) {
    AnchorDetailModel model = widget.model;

    return ChangeNotifierProvider<TabProvider>(
        create: (context2) => _tabProvider,
        child: Column(
          children: [
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
                AnchorDetailUserInfoWidget(model: model),
              ],
            ),
            const ColoredBox(
                color: Color.fromRGBO(236, 236, 236, 1.0),
                child: SizedBox(width: double.infinity, height: 0.5)),
            Expanded(
                child: Stack(
              alignment: Alignment.centerRight,
              children: [
                PageView.builder(
                    itemCount: _tabs.length,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) {
                      if (index == 0) {
                        return ChatPage(
                            roomId: model.roomId.toString(),
                            chatRoomId: model.chatId);
                      } else if (index == 1) {
                        return AnchorDetailCalendarPage(
                            anchorId: widget.anchorId);
                      } else {
                        return AnchorDetailPlaybackPage(
                            anchorId: widget.anchorId,
                            nickName: model.nickname);
                      }
                    }),
                StatefulBuilder(builder: (context, setState) {
                  _dataBtnSetter = setState;
                  return Visibility(
                    visible: _showDataBtn,
                    child: InkWell(
                      onTap: widget.callback,
                      child: Container(
                        width: 22,
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: JhImageUtils.getAssetImage(
                                  "anchor/icon_shuju_right"),
                              fit: BoxFit.cover),
                        ),
                        child: const Text("数\n据",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  );
                }),
              ],
            ))
          ],
        ));
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
