import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/wz_text_view.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class ChatBarWidget extends StatefulWidget {
  const ChatBarWidget({super.key});

  @override
  State createState() => _ChatBarWidgetState();
}

class _ChatBarWidgetState extends State<ChatBarWidget> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52 + ScreenUtil().bottomBarHeight,
      child: Column(
        children: [
          const Divider(height: 0.5, thickness: 1.0, color: ColorUtils.gray248),
          Row(children: [
            Container(
              color: Colors.yellow,
              child: IconButton(
                  onPressed: () {},
                  iconSize: 44,
                  icon: const JhAssetImage(
                    "anchor/iconMsgSet",
                    width: 24,
                  )),
            ),
            Expanded(
              child: Container(
                height: 36,
                decoration: const BoxDecoration(
                    color: ColorUtils.gray248,
                    borderRadius: BorderRadius.all(Radius.circular(18.0))),
                child: Row(children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: WZTextView(
                      textType: WZTextViewType.chat,
                      controller: _nameController,
                      focusNode: _nodeText1,
                      hintText: "说点什么吧",
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const JhAssetImage(
                        "anchor/iconMsgEmoji",
                        width: 24,
                      )),
                ]),
              ),
            ),
            InkWell(
              onTap: () {
                
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                alignment: Alignment.center,
                child: const Text("发送",
                    style: TextStyle(
                        color: ColorUtils.gray179,
                        fontSize: 12,
                        fontWeight: TextStyleUtils.regual)),
              ),
            )
          ]),
        ],
      ),
    ).colored(Colors.white);
  }
}
