import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/common/widget/follow_button.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MeFollowPage extends StatefulWidget {
  const MeFollowPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MeFollowPageState();
  }
}

class _MeFollowPageState extends State {

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    MeService.requestFollowList(FollowListType.anchor, (success, result) {
      if (success) {
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, titleText: "我的关注"),
        backgroundColor: ColorUtils.gray248,
        body: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: 10,
            separatorBuilder: (context, index) {
              return const Divider(
                  height: 0.5, color: ColorUtils.gray248, indent: 12);
            },
            itemBuilder: (context, index) {
              return _buildCellWidget(index);
            }));
  }

  _buildCellWidget(int idx) {
    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
              child: SizedBox(
                  width: 36,
                  height: 36,
                  child: buildNetImage("",
                      width: 36.0,
                      height: 36.0,
                      fit: BoxFit.cover,
                      placeholder: "common/iconTouxiang"))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "夏日清晨",
                  style: TextStyle(
                      color: const Color.fromRGBO(58, 58, 60, 1.0),
                      fontSize: 14.sp,
                      fontWeight: TextStyleUtils.medium),
                ),
                Text(
                  "粉丝数  2.9w",
                  style: TextStyle(
                      color: ColorUtils.gray149,
                      fontSize: 11.sp,
                      fontWeight: TextStyleUtils.regual),
                ),
              ],
            ),
          )),
          // FollowBtn(followed: true, handleFollow: () async {

          // }),
        ],
      ),
    );
  }
}
