import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/wz_text_view.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum ChatBarEvent { msgSet, edit, editEnd, emoji, msgSend }

const chatBarHeight = 44.0;

class ChatBarWidget extends StatefulWidget {
  final WZAnyCallback<ChatBarEvent> callback;

  const ChatBarWidget({super.key, required this.callback});

  @override
  State createState() => ChatBarWidgetState();
}

class ChatBarWidgetState extends State<ChatBarWidget> {
  textFocus(String emoji) {
    if (!_nodeText1.hasFocus) {
      _nodeText1.requestFocus();
    }
  }

  unfocus(String emoji) {
    if (_nodeText1.hasFocus) {
      _nodeText1.unfocus();
    }
  }

  insertEmoji(String emoji) {
    _nameController.text = _nameController.text + emoji;
  }

  deleteEmoji() {}

  // -------------------------------------------

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  @override
  void initState() {
    super.initState();
    _nodeText1.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _nodeText1.removeListener(_onFocusChange);
    _nodeText1.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    if (_nodeText1.hasFocus) {
      widget.callback(ChatBarEvent.edit);
    } else {
      widget.callback(ChatBarEvent.editEnd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: chatBarHeight + ScreenUtil().bottomBarHeight,
      child: Column(
        children: [
          const Divider(height: 0.5, thickness: 1.0, color: ColorUtils.gray248),
          Row(children: [
            IconButton(
                onPressed: () {},
                iconSize: 44,
                icon: const JhAssetImage(
                  "anchor/iconMsgSet",
                  width: 24,
                )),
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
                      onPressed: () {
                        if (_nodeText1.hasFocus) {
                          _nodeText1.unfocus();

                          // Future.delayed(const Duration(milliseconds: 200), () {
                            widget.callback(ChatBarEvent.emoji);
                          // });
                          
                        } else {
                          _nodeText1.requestFocus();
                        }
                      },
                      icon: const JhAssetImage(
                        "anchor/iconMsgEmoji",
                        width: 24,
                      )),
                ]),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
