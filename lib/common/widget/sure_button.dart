import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/text_style_utils.dart';

class SureButton extends StatelessWidget {
  final String title;
  final VoidCallback handleTap;

  const SureButton(
      {super.key, required this.title, required this.handleTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleTap,
      child: Container(
        width: ScreenUtil().screenWidth - 30.0,
        height: 45,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(233, 78, 78, 1.0),
                Color.fromRGBO(217, 52, 52, 1.0),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: TextStyleUtils.regual)),
      ),
    );
  }
}
