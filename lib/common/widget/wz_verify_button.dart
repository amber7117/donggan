import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class WZVerifyBtn extends StatefulWidget {
  const WZVerifyBtn({super.key, required this.handleVerify});

  final Future<bool> Function() handleVerify;

  @override
  State<StatefulWidget> createState() {
    return WZVerifyBtnState();
  }
}

class WZVerifyBtnState extends State<WZVerifyBtn> {
  bool _clickable = true;

  final int _second = 60;
  late int _currentSecond;

  StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _handleTap() async {
    bool isSuccess = await widget.handleVerify();
    if (!isSuccess) return;

    setState(() {
      _currentSecond = _second;
      _clickable = false;
    });

    Duration interval = const Duration(seconds: 1);
    _subscription =
        Stream.periodic(interval, (int i) => i).take(_second).listen((int i) {
      setState(() {
        _currentSecond = _second - i - 1;
        _clickable = _currentSecond < 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _clickable ? _handleTap : null,
        child: Container(
          width: 72.w,
          height: 22.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0,
                  color: _clickable
                      ? ColorUtils.red233
                      : const Color.fromRGBO(186, 195, 216, 1.0)),
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          child: Text(_clickable ? '获取验证码' : '$_currentSecond秒后重发',
              style: TextStyle(
                  color: _clickable
                      ? ColorUtils.red233
                      : const Color.fromRGBO(186, 195, 216, 1.0),
                  fontSize: 10.sp,
                  fontWeight: TextStyleUtils.medium)),
        ));
  }
}
