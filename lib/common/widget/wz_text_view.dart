import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum WZTextViewType { personalDesc }

class WZTextView extends StatefulWidget {
  final WZTextViewType textType;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autoFocus;
  final String hintText;

  const WZTextView(
      {super.key,
      required this.textType,
      required this.controller,
      this.focusNode,
      this.autoFocus = false,
      this.hintText = ''});

  @override
  State<StatefulWidget> createState() {
    return WZTextViewState();
  }
}

class WZTextViewState extends State<WZTextView> {
  _textMaxLength() {
    if (widget.textType == WZTextViewType.personalDesc) {
      return 200;
    }
    return 20;
  }

  _textFormatters() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: ColorUtils.black34,
        fontSize: 14.sp,
        fontWeight: TextStyleUtils.regual,
      ),
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      maxLength: _textMaxLength(),
      maxLines: null,
      obscureText: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      inputFormatters: _textFormatters(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: ColorUtils.gray149,
          fontSize: 14.sp,
          fontWeight: TextStyleUtils.regual,
        ),
        counterText: '',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
