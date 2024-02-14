import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class WZBackButton extends StatelessWidget {
  
  final WZVoidCallback? cb;

  const WZBackButton({super.key, this.cb});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Padding(
          padding: EdgeInsets.all(11),
          child: JhAssetImage("login/iconDengluBack", width: 22, height: 22)),
      onTap: () {
        cb != null ? cb!() : Routes.goBack(context);
      },
    );
  }
}


class WZBackBlackButton extends StatelessWidget {
  const WZBackBlackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Padding(
          padding: EdgeInsets.all(11),
          child: JhAssetImage("common/iconNavBack", width: 22, height: 22)),
      onTap: () {
        Routes.goBack(context);
      },
    );
  }
}
