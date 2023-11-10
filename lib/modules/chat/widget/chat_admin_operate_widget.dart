import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/modules/chat/entity/chat_user_info_entity.dart';
import 'package:wzty/utils/color_utils.dart';

const double chatAdminOperateItemHeight = 56.0;

class ChatAdminOperateWidget extends StatelessWidget {
  final ChatUserInfo chatInfo;
  final WZAnyCallback<int> callback;

  const ChatAdminOperateWidget(
      {super.key, required this.chatInfo, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 334 + ScreenUtil().bottomBarHeight,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          const SizedBox(height: 40),
          CircleImgPlaceWidget(
              imgUrl: chatInfo.headImgUrl,
              width: 48.0,
              placeholder: "common/iconTouxiang"),
          const SizedBox(height: 10),
          Text(chatInfo.nickname,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 200), () {
                callback(0);
              });
            },
            child: Container(
              width: double.infinity,
              height: chatAdminOperateItemHeight,
              alignment: Alignment.center,
              child: Text(chatInfo.isMute.isTrue() ? "解除禁言" : "禁言",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 200), () {
                callback(1);
              });
            },
            child: Container(
              width: double.infinity,
              height: chatAdminOperateItemHeight,
              alignment: Alignment.center,
              child: const Text("踢出",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
            ),
          ),
          const SizedBox(width: double.infinity, height: 10)
              .colored(ColorUtils.gray248),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: double.infinity,
                height: chatAdminOperateItemHeight,
                alignment: Alignment.center,
                child: const Text("取消",
                    style: TextStyle(
                        color: ColorUtils.gray153,
                        fontSize: 14,
                        fontWeight: FontWeight.normal))),
          )
        ],
      ),
    );
  }
}
