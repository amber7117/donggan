import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MeInfoNamePage extends StatefulWidget {
  const MeInfoNamePage({Key? key}) : super(key: key);

  @override
  State createState() => _MeInfoNamePageState();
}

class _MeInfoNamePageState extends State<MeInfoNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray248,
      appBar: buildAppBar(context: context, titleText: "修改昵称"),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            height: 68,
            padding: const EdgeInsets.only(left: 16, right: 16),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "当前昵称",
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 16.sp,
                      fontWeight: TextStyleUtils.regual),
                ),
                Text(
                  "HI，梅西",
                  style: TextStyle(
                      color: ColorUtils.gray149,
                      fontSize: 16.sp,
                      fontWeight: TextStyleUtils.regual),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 68,
            padding: const EdgeInsets.only(left: 16, right: 16),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "当前昵称",
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 16.sp,
                      fontWeight: TextStyleUtils.regual),
                ),
                Text(
                  "HI，梅西",
                  style: TextStyle(
                      color: ColorUtils.gray149,
                      fontSize: 16.sp,
                      fontWeight: TextStyleUtils.regual),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
