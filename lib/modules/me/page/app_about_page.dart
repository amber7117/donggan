import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class AppAboutPage extends StatefulWidget {
  const AppAboutPage({super.key});

  @override
  State createState() => _AppAboutPageState();
}

class _AppAboutPageState extends State<AppAboutPage> {
  final List<AboutListItemType> dataArr = [
    AboutListItemType.versionInfo,
    AboutListItemType.kefuQQ
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      appBar: buildAppBar(titleText: "关于我们"),
      body: Column(
        children: [
          _buildHeadWidget(),
          SizedBox(
            height: 55.h * 2,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                      color: ColorUtils.gray240, indent: 12, height: 0.5),
              itemBuilder: (BuildContext context, int index) {
                return _buildListItemWidget(dataArr[index]);
              },
            ),
          ),
          SizedBox(height: 310.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "用户协议",
                style: TextStyle(
                    color: Color.fromRGBO(91, 162, 214, 1.0),
                    fontSize: 13,
                    fontWeight: TextStyleUtils.regual),
              ),
              const SizedBox(width: 10.0),
              Container(
                  width: 1.0,
                  height: 14.h,
                  color: const Color.fromRGBO(91, 162, 214, 1.0)),
              const SizedBox(width: 10.0),
              const Text(
                "隐私政策",
                style: TextStyle(
                    color: Color.fromRGBO(91, 162, 214, 1.0),
                    fontSize: 13,
                    fontWeight: TextStyleUtils.regual),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          const SizedBox(
            width: 186,
            child: Text(
              "Copyright@2019-2020\n广西牧民科技有限公司 版权所有",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
        ],
      ),
    );
  }

  _buildHeadWidget() {
    return SizedBox(
        width: double.infinity,
        height: 200.h,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            JhAssetImage("common/logo80", width: 80),
            SizedBox(height: 15),
            Text('王者体育1.0.0',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: TextStyleUtils.regual)),
          ],
        ));
  }

  _buildListItemWidget(AboutListItemType type) {
    return Container(
      color: Colors.white,
      height: 55.h,
      padding: const EdgeInsets.only(left: 12, right: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type.title,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 14,
                fontWeight: TextStyleUtils.regual),
          ),
          Text(
            type.title,
            style: const TextStyle(
                color: ColorUtils.gray179,
                fontSize: 15,
                fontWeight: TextStyleUtils.regual),
          ),
        ],
      ),
    );
  }
}

enum AboutListItemType {
  versionInfo(title: "版本信息"),
  kefuQQ(title: "客服QQ");

  const AboutListItemType({
    required this.title,
  });

  final String title;
}
