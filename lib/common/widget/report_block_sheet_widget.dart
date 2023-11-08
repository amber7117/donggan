import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

enum ReportBlockType { reportLive, blockAnchor, blockLive }

class ReportBlockSheetWidget extends StatelessWidget {
  final List<ReportBlockType> dataArr;

  const ReportBlockSheetWidget({super.key, required this.dataArr});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(const SizedBox(width: 10));
    for (var type in dataArr) {
      children.add(_buildItemWidget(type));
    }

    return Container(
      width: double.infinity,
      height: 186 + ScreenUtil().bottomBarHeight, //34
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: children,
          ),
          const SizedBox(height: 20),
          const SizedBox(width: double.infinity, height: 10)
              .colored(ColorUtils.gray248),
          Container(
              width: double.infinity,
              height: 56,
              alignment: Alignment.center,
              child: const Text("取消",
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 14,
                      fontWeight: FontWeight.normal)))
        ],
      ),
    );
  }

  Widget _buildItemWidget(ReportBlockType type) {
    String imgPath;
    String title;
    if (type == ReportBlockType.reportLive) {
      imgPath = "anchor/icon_report";
      title = "举报直播间";
    } else if (type == ReportBlockType.blockAnchor) {
      imgPath = "anchor/icon_block_people";
      title = "屏蔽主播";
    } else if (type == ReportBlockType.blockLive) {
      imgPath = "anchor/icon_block_live";
      title = "屏蔽直播间";
    } else {
      imgPath = "anchor/icon_report";
      title = "举报";
    }
    return Container(
      width: 60,
      height: 80,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          JhAssetImage(imgPath, width: 56),
          const SizedBox(height: 7),
          Text(title,
              style: const TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 12,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
