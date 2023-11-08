import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

enum ReportBlockType { reportLive, blockAnchor, blockLive }

class ReportBlockSheetWidget extends StatelessWidget {
  final List<ReportBlockType> dataArr;

  const ReportBlockSheetWidget({super.key, required this.dataArr});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var type in dataArr) {
      children.add(_buildItemWidget(type));
    }

    return Column(
      children: [
        Row(
          children: children,
        ),
        const SizedBox(
            width: double.infinity,
            height: 56,
            child: Text("取消",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)))
      ],
    );
  }

  Widget _buildItemWidget(ReportBlockType type) {
    String imgPath;
    String title;
    if (type == ReportBlockType.reportLive) {
      imgPath = "anchor/icon_report";
      title = "举报直播间";
    } else if (type == ReportBlockType.reportLive) {
      imgPath = "anchor/icon_block_people";
      title = "屏蔽主播";
    } else if (type == ReportBlockType.reportLive) {
      imgPath = "anchor/icon_block_live";
      title = "屏蔽直播间";
    } else {
      imgPath = "anchor/icon_report";
      title = "举报";
    }
    return Column(
      children: [
        JhAssetImage(imgPath, width: 56),
        Text(title,
            style: const TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: FontWeight.normal)),
      ],
    );
  }
}
