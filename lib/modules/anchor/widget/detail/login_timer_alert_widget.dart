import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/widget/wz_sure_size_button.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class LoginTimerAlertWidget extends StatefulWidget {
  final bool forceLogin;
  final WZAnyCallback<bool> callback;

  const LoginTimerAlertWidget(
      {super.key, required this.forceLogin, required this.callback});

  @override
  State createState() => _LoginTimerAlertWidgetState();
}

class _LoginTimerAlertWidgetState extends State<LoginTimerAlertWidget> {
  late StreamSubscription loginEvent;

  @override
  void initState() {
    super.initState();

    loginEvent = eventBusManager.on<LoginStatusEvent>((event) {
      if (event.login) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    eventBusManager.off(loginEvent);
  }

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
                if (widget.forceLogin) {
                  widget.callback(true);

                  return;
                }

                Navigator.pop(context);

                Future.delayed(const Duration(milliseconds: 500), () {
                  widget.callback(true);
                });
              },
              width: 189.0,
              height: 36.0),
          const SizedBox(height: 20),
          widget.forceLogin
              ? const SizedBox(height: 36)
              : InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    widget.callback(false);
                  },
                  child: const JhAssetImage("anchor/login_hint_close",
                      width: 36, height: 36),
                )
        ],
      ),
    );
  }
}
