import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MePageState();
  }
}

class _MePageState extends State {
  List<Widget> _buildListItemWidgetArr() {
    return [
      _buildListItemWidget(MeListItemType.pingbi),
      _buildListItemWidget(MeListItemType.liulan),
      _buildListItemWidget(MeListItemType.huodong),
      _buildListItemWidget(MeListItemType.wenti),
      _buildListItemWidget(MeListItemType.kefu),
      _buildListItemWidget(MeListItemType.women),
    ];
  }

  _handleEvent(MeEvent event) {
    if (event == MeEvent.set) {
      Routes.push(context, Routes.appSet);
    }

    if (!UserManager.instance.isLogin()) {
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

  _handleListEvent(MeListItemType type) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  image: JhImageUtils.getAssetImage("me/bgMeHead"))),
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
                              "me/iconMessage", "消息通知", "0条未读"),
                          onTap: () {
                            _handleEvent(MeEvent.msg);
                          },
                        ),
                        InkWell(
                          child: _buildCardWidget("me/iconStar", "我的收藏", "收藏赛事"),
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
          padding: const EdgeInsets.only(top: 20, left: 20, right: 18, bottom: 16),
          child: InkWell(
            child: _buildInfoWidget(),
            onTap: () {
               _handleEvent(MeEvent.info);
            },
          )
        ),
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
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
              child: SizedBox(
                  width: 62.w,
                  child: provider.isLogin
                      ? buildNetImage(UserManager.instance.headImg,
                          width: 62.w,
                          height: 62.w,
                          fit: BoxFit.cover,
                          placeholder: "common/iconTouxiang")
                      : const JhAssetImage("common/iconTouxiang"))),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.isLogin ? UserManager.instance.nickName : "登录",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: TextStyleUtils.bold),
                    ),
                    Text(
                      provider.isLogin
                          ? UserManager.instance.personalDesc
                          : "您还没有登录，请登录",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12.sp,
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
            "1566",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: TextStyleUtils.medium),
          ),
          const SizedBox(width: 4),
          Text(
            isFollow ? "关注" : "粉丝",
            style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12.sp,
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
                style: TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 14.sp,
                    fontWeight: TextStyleUtils.medium),
              ),
              Text(
                desc,
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 12.sp,
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
                    style: TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 14.sp,
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
  pingbi(idx: 0, imgPath: "me/iconPingbi", title: "我的屏蔽"),
  liulan(idx: 1, imgPath: "me/iconJilu", title: "浏览记录"),
  huodong(idx: 2, imgPath: "me/iconGuangchang", title: "活动广场"),
  wenti(idx: 3, imgPath: "me/iconWenti", title: "常见问题"),
  kefu(idx: 4, imgPath: "me/iconKefu", title: "在线客服"),
  women(idx: 5, imgPath: "me/iconWomen", title: "关于我们");

  const MeListItemType({
    required this.idx,
    required this.imgPath,
    required this.title,
  });

  final int idx;
  final String imgPath;
  final String title;
}

enum MeEvent {
  set, info, follow, fans, msg, collect
}