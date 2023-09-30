

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/wz_button.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';


enum LoginTextFieldType {
  phone, verifyCode, pwd
}

class LoginTextField extends StatefulWidget {

  final LoginTextFieldType textType;
  final TextEditingController controller;
  final bool autoFocus;
  final String hintText;
  
  final FocusNode? focusNode;
  final Future<bool> Function()? getVCode;

  const LoginTextField(
      {super.key,
      required this.textType,
      required this.controller,
      this.focusNode,
      this.autoFocus = false,
      this.hintText = '',
      this.getVCode});
  
  @override
  State<StatefulWidget> createState() {
    return LoginTextFieldState();
  }
}

class LoginTextFieldState extends State<LoginTextField> {

  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时秒数
  final int _second = 60;

  /// 当前秒数
  late int _currentSecond;

  StreamSubscription<dynamic>? _subscription;
  
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
    _subscription?.cancel();
    widget.controller.removeListener(isEmpty);
    super.dispose();
  }

  Future<dynamic> _getVCode() async {
    final bool isSuccess = await widget.getVCode!();
    if (isSuccess) {
      setState(() {
        _currentSecond = _second;
        _clickable = false;
      });
      Duration interval = const Duration(seconds: 1);
      _subscription = Stream.periodic(interval, (int i) => i)
          .take(_second)
          .listen((int i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _clickable = _currentSecond < 1;
        });
      });
    }
  }

  _isTextVerifyCode() {
    return widget.textType == LoginTextFieldType.verifyCode;
  }

  _isTextPwd() {
    return widget.textType == LoginTextFieldType.pwd;
  }

  _textMaxLength() {
    if (widget.textType == LoginTextFieldType.phone) {
      return 11;
    } else if (widget.textType == LoginTextFieldType.verifyCode) {
      return 6;
    }
    return 20;
  }

  _textKeyboardType() {
    if (widget.textType == LoginTextFieldType.pwd) {
      return TextInputType.text;
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
            /// _isShowDelete参数动态变化，为了不破坏树结构使用Visibility，false时放一个空Widget。
            /// 对于其他参数，为初始配置参数，基本可以确定树结构，就不做空Widget处理。
            Visibility(
              visible: _isShowDelete,
              child: _buildClearButton() ?? const SizedBox(),
            ),
            if (_isTextPwd()) const SizedBox(height: 15),
            if (_isTextPwd()) _buildPwdEyeButton(),
            if (_isTextVerifyCode()) const SizedBox(height: 20),
            if (_isTextVerifyCode()) _buildVCodeButton(),
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
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      maxLength: _textMaxLength(),
      obscureText: _isTextPwd() && !_isShowPwd,
      textInputAction: TextInputAction.done,
      keyboardType: _textKeyboardType(),
      // 数字、手机号限制格式为0到9， 密码限制不包含汉字
      inputFormatters: _isTextPwd()
          ? [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))]
          : [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
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

  _buildVCodeButton() {
    return WZButton(
      key: const Key('getVerificationCode'),
      onPressed: _clickable ? _getVCode : null,
      text: _clickable ? '获取验证码' : '$_currentSecond秒后重发',
      fontSize: 10.sp,
      textColor: ColorUtils.red235,
      disabledTextColor: const Color.fromRGBO(186, 195, 216, 1.0),
      backgroundColor: Colors.white,
      disabledBackgroundColor: Colors.white,
      radius: 10.0,
      minHeight: 22.0,
      minWidth: 72.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      side: BorderSide(
        color: _clickable ? ColorUtils.red235 : const Color.fromRGBO(186, 195, 216, 1.0),
        width: 1.0,
      ),
    );
  }

  _buildPwdEyeButton() {
    return Semantics(
      label: '密码可见开关',
      hint: '密码是否可见',
      child: GestureDetector(
        child: Image(
          image: JhImageUtils.getAssetImage(_isShowPwd
              ? "login/iconDengluChakan1"
              : "login/iconDengluChakan2"),
          width: 20.0,
          height: 20.0,
        ),
        onTap: () {
          setState(() {
            _isShowPwd = !_isShowPwd;
          });
        },
      ),
    );
  }

  _buildClearButton() {
    return Semantics(
      label: '清空',
      hint: '清空输入框',
      child: GestureDetector(
        child: Image(
            image: JhImageUtils.getAssetImage("login/iconDengluGuanbi"),
            width: 20,
            height: 20),
        onTap: () => widget.controller.text = '',
      ),
    );
  }

}