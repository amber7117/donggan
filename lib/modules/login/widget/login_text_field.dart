

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/my_button.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class LoginTextField extends StatefulWidget {

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final bool isInputPwd;
  final FocusNode? focusNode;
  final Future<bool> Function()? getVCode;

  const LoginTextField(
      {super.key,
      required this.controller,
      this.maxLength = 11,
      this.autoFocus = false,
      this.keyboardType = TextInputType.text,
      this.hintText = '',
      this.isInputPwd = false,
      this.focusNode,
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
  final int _second = 30;

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
            if (widget.isInputPwd) const SizedBox(height: 15),
            if (widget.isInputPwd) _buildPwdEyeButton(),
            if (widget.getVCode != null) const SizedBox(height: 15),
            if (widget.getVCode != null) _buildVCodeButton(),
          ],
        )
      ],
    );
  }


  _buildTextField() {
    return TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.isInputPwd && !_isShowPwd,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      // 数字、手机号限制格式为0到9， 密码限制不包含汉字
      inputFormatters: (widget.keyboardType == TextInputType.number ||
              widget.keyboardType == TextInputType.phone)
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
          : [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: widget.hintText,
        counterText: '',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.8,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.8,
          ),
        ),
      ),
    );
  }

  _buildVCodeButton() {
    return MyButton(
      key: const Key('getVerificationCode'),
      onPressed: _clickable ? _getVCode : null,
      fontSize: 12.sp,
      text: _clickable ? '获取验证码' : '（$_currentSecond s）',
      textColor: Colors.white,
      disabledTextColor: Colors.white,
      backgroundColor: Colors.transparent,
      disabledBackgroundColor: Colors.white,
      radius: 1.0,
      minHeight: 26.0,
      minWidth: 76.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      side: BorderSide(
        color: _clickable ? Colors.white : Colors.transparent,
        width: 0.8,
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
            image: JhImageUtils.getAssetImage("login/iconDengluChakan2"),
            width: 20,
            height: 20),
        onTap: () => widget.controller.text = '',
      ),
    );
  }

}