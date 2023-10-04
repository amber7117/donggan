import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/login/service/login_service.dart';
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

  _handleListEvent(InfoListItemType type) {
    if (type == InfoListItemType.nickName) {
      Routes.push(context, Routes.meInfoName);
    }
  }

  _handleLogout() {
    LoginService.requestLogout((success, result) {});
    UserManager.instance.removeUser();
    
    context.read<UserProvider>().updateUserInfo(null);

    Routes.goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      appBar: buildAppBar(context: context, titleText: "编辑资料"),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Routes.push(context, Routes.meInfoAvatar);
            },
            child: _buildHeadWidget(),
          ),
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
          SizedBox(height: 140.h),
          WZSureButton(title: "退出登录", handleTap: _handleLogout),
        ],
      ),
    );
  }

  _buildHeadWidget() {
    return Container(
        width: double.infinity,
        height: 190.h,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: SizedBox(
                      width: 62,
                      height: 62,
                      child: Consumer<UserProvider>(
                          builder: (context, provider, child) {
                        return buildNetImage(provider.user?.headImg ?? "",
                            width: 62.0,
                            height: 62.0,
                            fit: BoxFit.cover,
                            placeholder: "common/iconTouxiang");
                      })),
                ),
                const JhAssetImage("me/iconXiangji", width: 28),
              ],
            ),
            const SizedBox(height: 16),
            Text('点击更换头像',
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 12.sp,
                    fontWeight: TextStyleUtils.regual)),
          ],
        ));
  }

  _buildListItemWidget(InfoListItemType type) {
    return InkWell(
      onTap:() {
        _handleListEvent(type);
      },
      child: Container(
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
                      fontWeight: TextStyleUtils.medium),
                )),
            const JhAssetImage("me/iconMeJiantou", width: 16.0, height: 16.0),
          ],
        ),
      ),
    );
  }
}

enum InfoListItemType {
  nickName(title: "我的昵称"),
  personalDesc(title: "个人简介"),
  modifyMobile(title: "手机号码"),
  modifyPwd(title: "修改密码"),
  cancelAccount(title: "注销账号");

  const InfoListItemType({
    required this.title,
  });

  final String title;
}
