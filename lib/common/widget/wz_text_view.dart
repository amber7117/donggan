import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum WZTextViewType {
  personalDesc
}

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
  bool _isShowDelete = false;

  @override
  void initState() {
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isNotEmpty;

    /// 监听输入改变
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  void isEmpty() {

  }

  @override
  void dispose() {
    widget.controller.removeListener(isEmpty);
    
    super.dispose();
  }

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
    return _buildTextField();
  }

  _buildTextField() {
    return TextField(
      style: TextStyle(
        color: ColorUtils.black51,
        fontSize: 16.sp,
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
          color: const Color.fromRGBO(202, 184, 184, 1.0),
          fontSize: 16.sp,
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

  
  _buildClearButton() {
    return Semantics(
      label: '清空',
      hint: '清空输入框',
      child: GestureDetector(
        child:
            const JhAssetImage("login/iconDengluGuanbi", width: 20, height: 20),
        onTap: () => widget.controller.text = '',
      ),
    );
  }
}
