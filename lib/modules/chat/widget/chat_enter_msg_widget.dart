import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

const double chatEnterMsgItemHeight = 56.0;

class ChatEnterMsgWidget extends StatelessWidget {
  final bool blockMsg;
  final WZAnyCallback<bool> callback;

  const ChatEnterMsgWidget(
      {super.key, required this.callback, required this.blockMsg});

  @override
  Widget build(BuildContext context) {
    double height = chatEnterMsgItemHeight * 2 + 10;

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
              callback(!blockMsg);
            },
            child: Container(
                width: double.infinity,
                height: chatEnterMsgItemHeight - 0.5,
                decoration: blockMsg
                    ? const BoxDecoration(
                        color: Color.fromRGBO(250, 240, 242, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)))
                    : const BoxDecoration(),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    JhAssetImage(
                        blockMsg ? "login/iconSelect" : "login/iconSelectNo",
                        width: 20),
                    Expanded(
                      child: Text("屏蔽入场消息",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: blockMsg
                                  ? ColorUtils.red233
                                  : ColorUtils.black34,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                    ),
                    const SizedBox(width: 20),
                  ],
                )),
          ),
          const SizedBox(width: double.infinity, height: 10)
              .colored(ColorUtils.gray248),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: double.infinity,
                height: chatEnterMsgItemHeight,
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
