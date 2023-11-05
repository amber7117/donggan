import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/main/user/user_entity.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MeInfoPage extends StatefulWidget {
  const MeInfoPage({super.key});

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
    } else if (type == InfoListItemType.personalDesc) {
      Routes.push(context, Routes.meInfoDesc);
    } else if (type == InfoListItemType.modifyMobile) {
      Routes.push(context, Routes.meInfoMobile);
    } else if (type == InfoListItemType.modifyPwd) {
      Routes.push(context, Routes.meInfoPwd);
    } else if (type == InfoListItemType.cancelAccount) {
      Routes.push(context, Routes.meInfoAccount);
    }
  }

  _handleLogout() {
    LoginService.requestLogout((success, result) {});
    UserManager.instance.removeUser();

    Routes.goBack(context);

    context.read<UserProvider>().updateUserInfo(null);

    eventBusManager.emit(LoginStatusEvent(login: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      appBar: buildAppBar(titleText: "编辑资料"),
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
            child: Consumer<UserProvider>(builder: (context, provider, child) {
              UserEntity? user = provider.user;
              if (user == null) {
                return const SizedBox();
              }
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataArr.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                        color: ColorUtils.gray240, indent: 12, height: 0.5),
                itemBuilder: (BuildContext context, int index) {
                  return _buildListItemWidget(dataArr[index], user);
                },
              );
            }),
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
            const Text('点击更换头像',
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.regual)),
          ],
        ));
  }

  _buildListItemWidget(InfoListItemType type, UserEntity user) {
    String vaule = "";
    if (type == InfoListItemType.nickName) {
      vaule = user.nickName;
    } else if (type == InfoListItemType.personalDesc) {
      vaule = user.personalDesc ?? "";
    } else if (type == InfoListItemType.modifyMobile) {
      vaule = user.getMobileDisplay();
    }
    return InkWell(
      onTap: () {
        _handleListEvent(type);
      },
      child: Container(
        color: Colors.white,
        height: 54.0,
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              type.title,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 14,
                  fontWeight: TextStyleUtils.regual),
            )),
            SizedBox(
              width: 230.w,
              child: Text(
                vaule,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: ColorUtils.gray179,
                    fontSize: 13,
                    fontWeight: TextStyleUtils.regual),
              ),
            ),
            const SizedBox(width: 6),
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
