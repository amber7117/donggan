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
  final bool showChat;
  final AnchorDetailModel model;
  final VoidCallback? callback;

  const AnchorDetailBottomPage(
      {super.key,
      required this.anchorId,
      this.showChat = true,
      required this.model,
      this.callback});

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

  final List<String> _tabTitles = ['预告', '回放'];
  final List<Widget> _tabs = [];

  late AnchorDetailModel _model;

  late StateSetter _dataBtnSetter;
  bool _showDataBtn = false;

  @override
  void initState() {
    super.initState();

    _model = widget.model;

    if (widget.showChat) {
      _tabTitles.insert(0, '聊球');
    }

    for (int i = 0; i < _tabTitles.length; i++) {
      _tabs.add(MatchDetailTabbarItemWidget(
        tabName: _tabTitles[i],
        index: i,
      ));
    }

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
                AnchorDetailUserInfoWidget(model: _model),
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
                      String title = _tabTitles[index];
                      if (title == "聊球") {
                        return ChatPage(
                            roomId: _model.roomId.toString(),
                            chatRoomId: _model.chatId);
                      } else if (title == "预告") {
                        return AnchorDetailCalendarPage(
                            anchorId: widget.anchorId);
                      } else if (title == "回放") {
                        return AnchorDetailPlaybackPage(
                            anchorId: widget.anchorId,
                            nickName: _model.nickname,
                            isDetailPage: widget.showChat);
                      } else {
                        return const SizedBox();
                      }
                    }),
                StatefulBuilder(builder: (context, setState) {
                  _dataBtnSetter = setState;
                  return Visibility(
                    visible: _showDataBtn && widget.callback != null,
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
