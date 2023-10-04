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
  final bool autoFocus;
  final String hintText;

  final FocusNode? focusNode;
  final Future<bool> Function()? getVCode;

  const WZTextView(
      {super.key,
      required this.textType,
      required this.controller,
      this.focusNode,
      this.autoFocus = false,
      this.hintText = '',
      this.getVCode});

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
    final bool isNotEmpty = widget.controller.text.isNotEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isNotEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isNotEmpty;
      });
    }
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
    if (widget.textType == WZTextViewType.personalDesc) {
      return [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))];
    } else {
      return null;
    }
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
      // 数字、手机号限制格式为0到9， 密码限制不包含汉字
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
