import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MeInfoPage extends StatefulWidget {
  const MeInfoPage({Key? key}) : super(key: key);

  @override
  State createState() => _MeInfoPageState();
}

class _MeInfoPageState extends State<MeInfoPage> {
  
  final List<InfoListItemType> dataArr = [
    InfoListItemType.nickName,
    InfoListItemType.personalDesc,
    InfoListItemType.modifyMobile,
    InfoListItemType.modifyPwd,
    InfoListItemType.cancelAccount,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      appBar: buildAppBar(titleText: "编辑资料", context: context),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: double.infinity,
              height: 190.h,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                      child: SizedBox(
                          width: 62,
                          height: 62,
                          child: buildNetImage(UserManager.instance.headImg,
                              width: 62.0,
                              height: 62.0,
                              fit: BoxFit.cover,
                              placeholder: "common/iconTouxiang"))),
                  const SizedBox(height: 16),
                  Text('点击更换头像',
                      style: TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 12.sp,
                          fontWeight: TextStyleUtils.regual)),
                ],
              )),
          SizedBox(
            height: 54.0 * dataArr.length,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataArr.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                      color: ColorUtils.gray240, indent: 12, height: 0.5),
              itemBuilder: (BuildContext context, int index) {
                return _buildListItemWidget(dataArr[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildListItemWidget(InfoListItemType type) {
    return Container(
      color: Colors.white,
      height: 54.0,
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
    );
  }
}

enum InfoListItemType {
  nickName(idx: 0, title: "我的昵称"),
  personalDesc(idx: 0, title: "个人简介"),
  modifyMobile(idx: 0, title: "手机号码"),
  modifyPwd(idx: 0, title: "修改密码"),
  cancelAccount(idx: 1, title: "注销账号");

  const InfoListItemType({
    required this.idx,
    required this.title,
  });

  final int idx;
  final String title;
}
