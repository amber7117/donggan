import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class AppSetPage extends StatefulWidget {
  const AppSetPage({super.key});

  @override
  State<AppSetPage> createState() => _AppSetPageState();
}

class _AppSetPageState extends State<AppSetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(titleText: "设置", context: context),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemExtent: 64.0,
        children: [
          _buildListItemWidget(SetListItemType.appUpdate),
          _buildListItemWidget(SetListItemType.cleanCache),
        ],
      ),
    );
  }

  _buildListItemWidget(SetListItemType type) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 16, bottom: 20, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                type.title,
                style: TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              )),
          const JhAssetImage("me/iconMeJiantou", width: 16.0, height: 16.0),
        ],
      ),
    );
  }
}


enum SetListItemType {
  appUpdate(idx: 0, title: "检查更新"),
  cleanCache(idx: 1, title: "清除缓存");

  const SetListItemType({
    required this.idx,
    required this.title,
  });

  final int idx;
  final String title;
}
