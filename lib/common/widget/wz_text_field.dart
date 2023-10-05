import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/wz_verify_button.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum WZTextFieldType {
  phone,
  verifyCode,
  pwd,
  nickName,
}

class WZTextField extends StatefulWidget {
  final WZTextFieldType textType;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autoFocus;
  final String hintText;

  final Future<bool> Function()? getVCode;

  const WZTextField(
      {super.key,
      required this.textType,
      required this.controller,
      this.focusNode,
      this.autoFocus = false,
      this.hintText = '',
      this.getVCode});

  @override
  State<StatefulWidget> createState() {
    return WZTextFieldState();
  }
}

class WZTextFieldState extends State<WZTextField> {
  bool _isShowPwd = false;
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

  _isPwdText() {
    return widget.textType == WZTextFieldType.pwd;
  }

  _textMaxLength() {
    if (widget.textType == WZTextFieldType.phone) {
      return 11;
    } else if (widget.textType == WZTextFieldType.verifyCode) {
      return 6;
    } else if (widget.textType == WZTextFieldType.nickName) {
      return 12;
    }
    return 20;
  }

  _textFormatters() {
    if (widget.textType == WZTextFieldType.pwd) {
      return [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))];
    } else if (widget.textType == WZTextFieldType.nickName) {
      return null;
    } else {
      return [FilteringTextInputFormatter.allow(RegExp('[0-9]'))];
    }
  }

  _textKeyboardType() {
    if (widget.textType == WZTextFieldType.pwd) {
      return TextInputType.text;
    } else if (widget.textType == WZTextFieldType.nickName) {
      return TextInputType.name;
    }
    return TextInputType.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        _buildTextField(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: _isShowDelete,
              child: _buildClearButton() ?? const SizedBox(),
            ),
            if (_isPwdText()) const SizedBox(height: 15),
            if (_isPwdText()) _buildPwdEyeButton(),
            if (widget.getVCode != null) const SizedBox(height: 20),
            if (widget.getVCode != null) WZVerifyBtn(handleVerify: widget.getVCode!),
          ],
        )
      ],
    );
  }

  _buildTextField() {
    return TextField(
      style: TextStyle(
        color: ColorUtils.black51,
        fontSize: 16.sp,
        fontWeight: TextStyleUtils.regual,
      ),
      textAlign: TextAlign.left,
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      maxLength: _textMaxLength(),
      obscureText: _isPwdText() && !_isShowPwd,
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

  _buildPwdEyeButton() {
    return Semantics(
      label: '密码可见开关',
      hint: '密码是否可见',
      child: GestureDetector(
        child: JhAssetImage(
            _isShowPwd ? "login/iconDengluChakan1" : "login/iconDengluChakan2",
            width: 20,
            height: 20),
        onTap: () {
          setState(() {
            _isShowPwd = !_isShowPwd;
          });
        },
      ),
    );
  }
}
