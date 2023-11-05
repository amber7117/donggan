import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/wz_text_view.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum NewsDetailTextEvent { edit, editEnd, msgSend }

const chatBarHeight = 52.5;

class NewsDetailTextWidget extends StatefulWidget {
  final WZAnyCallback<NewsDetailTextEvent> callback;

  const NewsDetailTextWidget({super.key, required this.callback});

  @override
  State createState() => NewsDetailTextWidgetState();
}

class NewsDetailTextWidgetState extends State<NewsDetailTextWidget> {
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

  // -------------------------------------------

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  late StateSetter _btnSetter;
  bool _canSend = false;

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
      widget.callback(NewsDetailTextEvent.edit);
    } else {
      widget.callback(NewsDetailTextEvent.editEnd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: chatBarHeight,
      child: Column(
        children: [
          const Divider(height: 0.5, thickness: 1.0, color: ColorUtils.gray248),
          Row(children: [
            Expanded(
              child: Container(
                  height: 36,
                  margin: const EdgeInsets.only(left: 18),
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: const BoxDecoration(
                      color: ColorUtils.gray248,
                      borderRadius: BorderRadius.all(Radius.circular(18.0))),
                  child: WZTextView(
                    textType: WZTextViewType.chat,
                    controller: _nameController,
                    focusNode: _nodeText1,
                    hintText: "我也来说几句",
                  )),
            ),
            StatefulBuilder(builder: (context, setState) {
              _btnSetter = setState;
              return InkWell(
                onTap: _canSend
                    ? () {
                        widget.callback(NewsDetailTextEvent.msgSend);
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
