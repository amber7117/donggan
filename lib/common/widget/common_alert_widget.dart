import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum CommonAlertType {
  blockUserMsg,
  deleteUserMsg,
  forbidUserChat,
  forbidUserChatNo,
  kickoutUser,
}

class CommonAlertWidget extends StatelessWidget {
  final CommonAlertType type;
  final String content;
  final VoidCallback callback;

  const CommonAlertWidget(
      {super.key,
      required this.type,
      required this.content,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    double marginY;
    if (type == CommonAlertType.blockUserMsg) {
      marginY = (popContentHeight() - 172.0) * 0.5;
    } else {
      marginY = (popContentHeight() - 148.0) * 0.5;
    }

    Widget titleWidget;
    if (type == CommonAlertType.blockUserMsg) {
      titleWidget = _buildBlockMsgWidget();
    } else if (type == CommonAlertType.deleteUserMsg) {
      titleWidget = _buildDeleteMsgWidget();
    } else {
      titleWidget = _buildAdminOperateWidget();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: marginY),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          titleWidget,
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 122,
                height: 40,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(250, 250, 250, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                    child: const Text('取消',
                        style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1.0),
                            fontSize: 16,
                            fontWeight: TextStyleUtils.regual)),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                width: 122,
                height: 40,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorUtils.red233,
                        ColorUtils.red217,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                    child: const Text('确认',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: TextStyleUtils.regual)),
                    onPressed: () {
                      callback();
                    }),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _buildBlockMsgWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("屏蔽",
                style: TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 16,
                    fontWeight: TextStyleUtils.regual)),
            Text(content,
                style: const TextStyle(
                    color: ColorUtils.red233,
                    fontSize: 16,
                    fontWeight: TextStyleUtils.regual)),
          ],
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("选择屏蔽用户之后，将不再向您展示该用户的聊天内容",
              style: TextStyle(
                  color: ColorUtils.black51,
                  fontSize: 16,
                  fontWeight: TextStyleUtils.regual)),
        ),
      ],
    );
  }

  _buildDeleteMsgWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("删除",
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 16,
                fontWeight: TextStyleUtils.regual)),
        Text(content,
            style: const TextStyle(
                color: ColorUtils.red233,
                fontSize: 16,
                fontWeight: TextStyleUtils.regual))
      ],
    );
  }

  _buildAdminOperateWidget() {
    String title;

    if (type == CommonAlertType.forbidUserChat) {
      title = "禁言";
    } else if (type == CommonAlertType.forbidUserChatNo) {
      title = "解除禁言";
    } else {
      title = "踢出";
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 16,
                fontWeight: TextStyleUtils.regual)),
        Text(content,
            style: const TextStyle(
                color: ColorUtils.red233,
                fontSize: 16,
                fontWeight: TextStyleUtils.regual)),
        const Text("吗",
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 16,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }
}
