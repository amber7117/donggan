import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/wz_sure_size_button.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class LoginTimerAlertWidget extends StatelessWidget {
  final bool forceLogin;
  final WZAnyCallback<bool> callback;

  const LoginTimerAlertWidget(
      {super.key, required this.forceLogin, required this.callback});

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 466.0) * 0.5;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: marginY),
      child: Column(
        children: [
          const JhAssetImage("anchor/login_hint_bg", width: 347, height: 364),
          const SizedBox(height: 10),
          WZSureSizeButton(
              title: "去登录",
              handleTap: () {
                if (forceLogin) {
                  Routes.goLoginPage(context);
                  return;
                }
                
                Navigator.pop(context);
                callback(false);

                Future.delayed(const Duration(milliseconds: 500), () {
                  Routes.goLoginPage(context);
                });
              },
              width: 189.0,
              height: 36.0),
          const SizedBox(height: 20),
          forceLogin
              ? const SizedBox(height: 36)
              : InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    callback(false);
                  },
                  child: const JhAssetImage("anchor/login_hint_close",
                      width: 36, height: 36),
                )
        ],
      ),
    );
  }
}
