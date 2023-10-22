import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum WZTextViewType { personalDesc }

class WZTextView extends StatefulWidget {
  final WZTextViewType textType;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autoFocus;
  final String hintText;
  final int maxLength;

  const WZTextView(
      {super.key,
      required this.textType,
      required this.controller,
      this.focusNode,
      this.autoFocus = false,
      this.hintText = '',  
      this.maxLength = 200});

  @override
  State<StatefulWidget> createState() {
    return WZTextViewState();
  }
}

class WZTextViewState extends State<WZTextView> {
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: ColorUtils.black34,
        fontSize: 14,
        fontWeight: TextStyleUtils.regual,
      ),
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      maxLength: widget.maxLength,
      maxLines: null,
      obscureText: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      inputFormatters: null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: ColorUtils.gray149,
          fontSize: 14,
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
