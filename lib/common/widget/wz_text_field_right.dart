import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum WZTextFieldRightType {
  mobile,
}

class WZTextFieldRight extends StatefulWidget {
  final WZTextFieldRightType textType;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autoFocus;
  final String hintText;

  final Future<bool> Function()? getVCode;

  const WZTextFieldRight(
      {super.key,
      required this.textType,
      required this.controller,
      this.focusNode,
      this.autoFocus = false,
      this.hintText = '',
      this.getVCode});

  @override
  State<StatefulWidget> createState() {
    return WZTextFieldRightState();
  }
}

class WZTextFieldRightState extends State<WZTextFieldRight> {
  bool _isShowDelete = false;

  @override
  void initState() {
    super.initState();

    _isShowDelete = widget.controller.text.isNotEmpty;

    /// 监听输入改变
    widget.controller.addListener(isEmpty);
  }

  @override
  void dispose() {
    widget.controller.removeListener(isEmpty);

    super.dispose();
  }

  void isEmpty() {
    bool isNotEmpty = widget.controller.text.isNotEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if (_isShowDelete == isNotEmpty) return;

    setState(() {
      _isShowDelete = isNotEmpty;
    });
  }

  _textMaxLength() {
    if (widget.textType == WZTextFieldRightType.mobile) {
      return 11;
    }
    return 20;
  }

  _textFormatters() {
    return [FilteringTextInputFormatter.allow(RegExp('[0-9]'))];
  }

  _textKeyboardType() {
    return TextInputType.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Padding(
          padding: _isShowDelete
              ? const EdgeInsets.only(right: 25)
              : EdgeInsets.zero,
          child: _buildTextField(),
        ),
        Visibility(
          visible: _isShowDelete,
          child: _buildClearButton() ?? const SizedBox(),
        ),
      ],
    );
  }

  _buildTextField() {
    return TextField(
      style: const TextStyle(
        color: ColorUtils.black51,
        fontSize: 16,
        fontWeight: TextStyleUtils.regual,
      ),
      textAlign: TextAlign.right,
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      maxLength: _textMaxLength(),
      obscureText: false,
      textInputAction: TextInputAction.done,
      keyboardType: _textKeyboardType(),
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
