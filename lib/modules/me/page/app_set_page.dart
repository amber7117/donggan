import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class AppSetPage extends StatefulWidget {
  const AppSetPage({super.key});

  @override
  State<AppSetPage> createState() => _AppSetPageState();
}

class _AppSetPageState extends State<AppSetPage> {
  final List<SetListItemType> dataArr = [
    SetListItemType.appUpdate,
    SetListItemType.cleanCache
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.gray248,
        appBar: buildAppBar(titleText: "设置", context: context),
        body: ListView.separated(
          itemCount: dataArr.length,
          padding: const EdgeInsets.only(top: 10),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(color: ColorUtils.gray240, indent: 12, height: 0.5),
          itemBuilder: (BuildContext context, int index) {
            return _buildListItemWidget(dataArr[index]);
          },
        ));
  }

  _buildListItemWidget(SetListItemType type) {
    return InkWell(
      child: Container(
        color: Colors.white,
        height: 56,
        padding: const EdgeInsets.only(left: 12, right: 12),
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
      ),
      onTap: () {
        if (type == SetListItemType.appUpdate) {
          ToastUtils.showInfo("当前已是最新版本");
        } else if (type == SetListItemType.cleanCache) {}
      },
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
