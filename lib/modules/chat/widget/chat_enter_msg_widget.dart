import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

const double chatEnterMsgItemHeight = 56.0;

class ChatEnterMsgWidget extends StatelessWidget {
  final WZAnyCallback<bool> callback;

  const ChatEnterMsgWidget({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    double height = chatEnterMsgItemHeight * 2 + 10;
    String iconPath = "login/iconSelect";
    return Container(
      width: double.infinity,
      height: height + ScreenUtil().bottomBarHeight,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              callback(true);
            },
            child: Container(
                width: double.infinity,
                height: chatEnterMsgItemHeight - 0.5,
                decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    JhAssetImage(iconPath, width: 20),
                    const Expanded(
                      child: Text("屏蔽入场消息",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                    ),
                    const SizedBox(width: 20),
                  ],
                )),
          ),
          const SizedBox(width: double.infinity, height: 10)
              .colored(ColorUtils.gray248),
          Container(
              width: double.infinity,
              height: chatEnterMsgItemHeight,
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
}
