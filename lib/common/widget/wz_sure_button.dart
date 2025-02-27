import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';

class WZSureButton extends StatelessWidget {
  final String title;
  final VoidCallback handleTap;
  final bool enable;

  const WZSureButton(
      {super.key,
      required this.title,
      required this.handleTap,
      this.enable = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? handleTap : null,
      child: Container(
        width: ScreenUtil().screenWidth - 30.0,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: enable
                  ? [
                      ColorUtils.red233,
                      ColorUtils.red217,
                    ]
                  : [
                      ColorUtils.red233.withOpacity(0.5),
                      ColorUtils.red217.withOpacity(0.5),
                    ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal)),
      ),
    );
  }
}
