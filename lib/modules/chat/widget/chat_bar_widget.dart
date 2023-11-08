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
  textFocus() {
    if (!_nodeText1.hasFocus) {
      _nodeText1.requestFocus();
    }
  }

  textUnfocus() {
    if (_nodeText1.hasFocus) {
      _nodeText1.unfocus();
    }
  }

  getText() {
    return _nameController.text;
  }

  clearText() {
    _nameController.text = "";
  }

  insertEmoji(String emoji) {
    _lastEmoji = emoji;
    _nameController.text = _nameController.text + emoji;
  }

  deleteEmoji() {
    if (_lastEmoji.isEmpty) {
      return;
    }
    String text = _nameController.text;
    _nameController.text = _nameController.text.substring(0, text.length - _lastEmoji.length);
    _lastEmoji = "";
  }

  // -------------------------------------------

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  late StateSetter _btnSetter;
  bool _canSend = false;

  String _lastEmoji = "";

  @override
  void initState() {
    super.initState();
    _nodeText1.addListener(_onFocusChange);
    _nameController.addListener(_textVerify);
  }

  @override
  void dispose() {
    _nodeText1.removeListener(_onFocusChange);
    _nameController.removeListener(_textVerify);

    super.dispose();
  }

  _textVerify() {
    _canSend = _nameController.text.isNotEmpty;
    _btnSetter(() {});
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
                onPressed: () {
                  widget.callback(ChatBarEvent.msgSet);
                },
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
            StatefulBuilder(builder: (context, setState) {
              _btnSetter = setState;
              return InkWell(
                onTap: _canSend
                    ? () {
                        widget.callback(ChatBarEvent.msgSend);
                      }
                    : null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  alignment: Alignment.center,
                  child: Text("发送",
                      style: TextStyle(
                          color:
                              _canSend ? ColorUtils.red233 : ColorUtils.gray179,
                          fontSize: 16,
                          fontWeight: TextStyleUtils.regual)),
                ),
              );
            }),
          ]),
        ],
      ),
    ).colored(Colors.white);
  }
}
