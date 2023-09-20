import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/colors.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MePageState();
  }
}

class _MePageState extends State {

  final List<MeListItemType> _itemList = [
    MeListItemType.pingbi,
    MeListItemType.liulan,
    MeListItemType.huodong,
    MeListItemType.wenti,
    MeListItemType.kefu,
    MeListItemType.women,
  ];  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.gray248,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
              color: Colors.yellow,
              height: 200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCardWidget("me/iconMessage", "消息通知", "0条未读"),
                      _buildCardWidget("me/iconStar", "我的收藏", "收藏赛事"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverFixedExtentList.list(itemExtent: 64.0, children: [
            _buildListItemWidget(MeListItemType.pingbi),
            _buildListItemWidget(MeListItemType.liulan),
            _buildListItemWidget(MeListItemType.huodong),
            _buildListItemWidget(MeListItemType.wenti),
            _buildListItemWidget(MeListItemType.kefu),
            _buildListItemWidget(MeListItemType.women),
          ])
        ],
      ),
    );
  }

  _buildCardWidget(String imgPath, String title, String desc) {
    return Container(
      height: 64.0,
      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 40),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          JhAssetImage(imgPath, width: 44.0, height: 44.0),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: ThemeColor.black34,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  desc,
                  style: TextStyle(
                      color: ThemeColor.gray153,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildListItemWidget(MeListItemType type) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.only(top: 20, left: 16, bottom: 20, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              JhAssetImage(type.imgPath, width: 24.0, height: 24.0),
              Text(
                type.title,
                style: TextStyle(
                    color: ThemeColor.black34,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const JhAssetImage("me/iconMeJiantou", width: 16.0, height: 16.0),
        ],
      ),
    );
  }
}



enum MeListItemType  {

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