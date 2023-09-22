import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class LoginContentWidget extends StatefulWidget {

  final LoginContentType type;

  const LoginContentWidget({super.key, required this.type});

  @override
  State<StatefulWidget> createState() {
    return _LoginContentState();
  }
}

class _LoginContentState extends State {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildItemWidget(),
        _buildItemWidget(),
      ],
    );
  }

  _buildItemWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "手机号",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black51,
                fontSize: 18.sp,
                fontWeight: TextStyleUtils.bold),
          ),
          const SizedBox(height: 10),
          _buildTextWidget(),
          const SizedBox(height: 10),
          Divider(color:  ColorUtils.rgb(216, 216, 216), height: 0.5),
        ],
      ),
    );
  }

  _buildTextWidget() {
    return Row(
      children: [
        Image(
          image: JhImageUtils.getAssetImage("login/iconDengluShoujihao"),
          width: 22,
          height: 22,
        ),
        Text(
          "+86",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ColorUtils.black51,
              fontSize: 16.sp,
              fontWeight: TextStyleUtils.regual),
        ),
      ],
    );
  }
}


enum LoginContentType {
  verifyCode,
  pwd
}

