import 'package:flutter/material.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/utils/cache_utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  String _fileSize = "";

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() async {
    double value = await CacheUtils.loadAppCache();
    _fileSize = CacheUtils.formatSize(value);

    setState(() {});
  }

  // -------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.gray248,
        appBar: buildAppBar(titleText: "设置"),
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
    String value = "";
    if (type == SetListItemType.cleanCache) {
      value = _fileSize;
    }
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
                  style: const TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 14,
                      fontWeight: TextStyleUtils.regual),
                )),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 14,
                  fontWeight: TextStyleUtils.regual),
            ),
            const JhAssetImage("me/iconMeJiantou", width: 16.0, height: 16.0),
          ],
        ),
      ),
      onTap: () {
        if (type == SetListItemType.appUpdate) {
          ToastUtils.showInfo("当前已是最新版本");
        } else if (type == SetListItemType.cleanCache) {
          ToastUtils.showSuccess("缓存清除成功");
          CacheUtils.clearAppCache2();
          _fileSize = "";
          setState(() {});
        }
      },
    );
  }
}

enum SetListItemType {
  appUpdate(title: "检查更新"),
  cleanCache(title: "清除缓存");

  const SetListItemType({
    required this.title,
  });

  final String title;
}
