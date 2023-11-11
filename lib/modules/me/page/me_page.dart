import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/user/user_entity.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/me/entity/sys_msg_entity.dart';
import 'package:wzty/modules/me/entity/user_info_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MePageState();
  }
}

class _MePageState extends KeepAliveLifeWidgetState<MePage> {
  List<Widget> _buildListItemWidgetArr() {
    return [
      _buildListItemWidget(MeListItemType.pingbi),
      _buildListItemWidget(MeListItemType.jilu),
      _buildListItemWidget(MeListItemType.huodong),
      _buildListItemWidget(MeListItemType.wenti),
      _buildListItemWidget(MeListItemType.kefu),
      _buildListItemWidget(MeListItemType.women),
    ];
  }

  late StreamSubscription _eventSub;
  UserInfoEntity? userInfo2;
  List<SysMsgModel> msgList = [];

  @override
  void initState() {
    super.initState();

    _requestData();

    _eventSub = eventBusManager.on<LoginStatusEvent>((event) {
      _handleLoginEvent(event);
    });
  }

  @override
  void dispose() {
    super.dispose();

    eventBusManager.off(_eventSub);
  }

  @override
  void onPageResume() {
    super.onPageResume();
  }

  _requestData() {
    if (!UserManager.instance.isLogin()) return;

    Future info =
        MeService.requestUserInfo(UserManager.instance.uid, (success, result) {
      userInfo2 = result;
    });

    Future msg = MeService.requestSysMsgList((success, result) {
      msgList = result;
    });

    Future.wait([info, msg]).then((value) {
      String desc = userInfo2?.personalDesc ?? "";
      if (desc.isNotEmpty) {
        UserManager.instance.updateUserPersonalDesc(desc);
        context
            .read<UserProvider>()
            .updateUserInfoPart(personalDesc: desc, notify: false);
      }
      setState(() {});
    });
  }

  _handleLoginEvent(LoginStatusEvent event) {
    if (event.login) {
      _requestData();
    } else {
      userInfo2 = null;
      msgList = [];
      setState(() {});
    }
  }

  _handleEvent(MeEvent event) {
    if (event == MeEvent.set) {
      Routes.push(context, Routes.appSet);
      return;
    }

    if (context.read<UserProvider>().user == null) {
      Routes.goLoginPage(context);
      return;
    }

    if (event == MeEvent.info) {
      Routes.push(context, Routes.meInfo);
    } else if (event == MeEvent.follow) {
      Routes.push(context, Routes.meFollow);
    } else if (event == MeEvent.fans) {
      Routes.push(context, Routes.meFans);
    } else if (event == MeEvent.msg) {
      Routes.push(context, Routes.meMsg);
    } else if (event == MeEvent.collect) {
      Routes.push(context, Routes.meCollect);
    }
  }

  _handleListEvent(MeListItemType type) {
    if (type == MeListItemType.pingbi) {
      Routes.push(context, Routes.mePingbi);
    } else if (type == MeListItemType.jilu) {
      if (context.read<UserProvider>().user == null) {
        Routes.goLoginPage(context);
        return;
      }

      Routes.push(context, Routes.meJilu);
    } else if (type == MeListItemType.huodong) {
      Routes.push(context, Routes.meHuodong);
    } else if (type == MeListItemType.wenti) {
      Routes.push(context, Routes.meWenti);
    } else if (type == MeListItemType.kefu) {
      String linkNew =
          Uri.encodeQueryComponent(ConfigManager.instance.onlineKefu);
      // linkNew = "https://www.baidu.com";
      Routes.push(context, Routes.web,
          arguments: {"title": "在线客服", "urlStr": linkNew});
    } else {
      Routes.push(context, Routes.meAbout);
    }
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  image: JhImageUtils.getAssetImage("me/bgMeHead", x2: false))),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),
              SizedBox(
                height: 190.h,
                child: _buildHeadWidget(),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                height: 104.h,
                decoration: const BoxDecoration(
                    color: ColorUtils.gray248,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: _buildCardWidget(
                              "me/iconMessage", "消息通知", "${msgList.length}条未读"),
                          onTap: () {
                            _handleEvent(MeEvent.msg);
                          },
                        ),
                        InkWell(
                          child:
                              _buildCardWidget("me/iconStar", "我的收藏", "收藏赛事"),
                          onTap: () {
                            _handleEvent(MeEvent.collect);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 64.h * 6,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemExtent: 64.h,
                  children: _buildListItemWidgetArr(),
                ),
              )
            ],
          )),
    );
  }

  _buildHeadWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
            child: const JhAssetImage("me/iconSet", width: 24, height: 24),
            onPressed: () {
              _handleEvent(MeEvent.set);
            }),
        Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 18, bottom: 16),
            child: InkWell(
              child: _buildInfoWidget(),
              onTap: () {
                _handleEvent(MeEvent.info);
              },
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: _buildFansWidget(true),
              onTap: () {
                _handleEvent(MeEvent.follow);
              },
            ),
            Container(
              width: 1,
              height: 26,
              color: Colors.white.withOpacity(0.2),
            ),
            InkWell(
              child: _buildFansWidget(false),
              onTap: () {
                _handleEvent(MeEvent.fans);
              },
            ),
          ],
        )
      ],
    );
  }

  _buildInfoWidget() {
    return Consumer<UserProvider>(builder: (context2, provider, child) {
      UserEntity? user = provider.user;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleImgPlaceWidget(
              imgUrl: user?.headImg ?? "",
              width: 62,
              placeholder: "common/iconTouxiang"),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null ? user.nickName : "登录",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: TextStyleUtils.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user != null ? (user.personalDesc ?? "") : "您还没有登录，请登录",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: TextStyleUtils.regual),
                    ),
                  ],
                )),
          ),
          const JhAssetImage("me/iconMeJiantou2", width: 16.0, height: 16.0),
        ],
      );
    });
  }

  _buildFansWidget(bool isFollow) {
    return SizedBox(
      width: 175.w,
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isFollow
                ? "${userInfo2?.focusCount ?? 0}"
                : "${userInfo2?.fansCount ?? 0}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: TextStyleUtils.medium),
          ),
          const SizedBox(width: 4),
          Text(
            isFollow ? "关注" : "粉丝",
            style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
                fontWeight: TextStyleUtils.medium),
          ),
        ],
      ),
    );
  }

  _buildCardWidget(String imgPath, String title, String desc) {
    return Container(
      width: 171.w,
      height: 84.h,
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          JhAssetImage(imgPath, width: 44.0, height: 44.0),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 14,
                    fontWeight: TextStyleUtils.medium),
              ),
              Text(
                desc,
                style: const TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.medium),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildListItemWidget(MeListItemType type) {
    return InkWell(
      onTap: () {
        _handleListEvent(type);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            JhAssetImage(type.imgPath, width: 24.0, height: 24.0),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    type.title,
                    style: const TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 14,
                        fontWeight: TextStyleUtils.medium),
                  )),
            ),
            const JhAssetImage("me/iconMeJiantou", width: 16.0, height: 16.0),
          ],
        ),
      ),
    );
  }
}

enum MeListItemType {
  pingbi(imgPath: "me/iconPingbi", title: "我的屏蔽"),
  jilu(imgPath: "me/iconJilu", title: "浏览记录"),
  huodong(imgPath: "me/iconGuangchang", title: "活动广场"),
  wenti(imgPath: "me/iconWenti", title: "常见问题"),
  kefu(imgPath: "me/iconKefu", title: "在线客服"),
  women(imgPath: "me/iconWomen", title: "关于我们");

  const MeListItemType({
    required this.imgPath,
    required this.title,
  });

  final String imgPath;
  final String title;
}

enum MeEvent { set, info, follow, fans, msg, collect }
