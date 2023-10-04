import 'package:flutter/material.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class WZBackButton extends StatelessWidget {
  const WZBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Padding(
          padding: EdgeInsets.all(11),
          child: JhAssetImage("login/iconDengluBack", width: 22, height: 22)),
      onTap: () {
        Routes.goBack(context);
      },
    );
  }
}
