import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MeInfoPage extends StatefulWidget {
  const MeInfoPage({Key? key}) : super(key: key);

  @override
  State createState() => _MeInfoPageState();
}

class _MeInfoPageState extends State<MeInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      appBar: buildAppBar(titleText: "编辑资料", context: context),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 190.h,
              color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                      child: SizedBox(
                          width: 62,
                          height: 62,
                          child: buildNetImage(UserManager.instance.headImg,
                              width: 62.0,
                              height: 62.0,
                              fit: BoxFit.cover,
                              placeholder: "common/iconTouxiang"))),
                  const SizedBox(height: 16),
                  Text('点击更换头像',
                      style: TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 12.sp,
                          fontWeight: TextStyleUtils.regual)),
                ],
              )),
        ],
      ),
    );
  }
}
