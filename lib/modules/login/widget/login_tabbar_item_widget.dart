import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/home_tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class LoginTabbarItemWidget extends StatelessWidget {
  final String tabName;

  final int index;

  const LoginTabbarItemWidget(
      {super.key, required this.tabName, required this.index});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: (ScreenUtil().screenWidth-18*2)*0.5,
        height: 48.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
                visible: context.watch<HomeTabProvider>().index != index,
                child: JhAssetImage(index == 0
                    ? "login/iconDengluBtn1"
                    : "login/iconDengluBtn2", fit: BoxFit.fitHeight)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tabName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 14.sp,
                      fontWeight: TextStyleUtils.semibold),
                ),
                const DecoratedBox(
                    decoration: BoxDecoration(
                        color: ColorUtils.red235,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: SizedBox(height: 4, width: 16))
              ],
            )
          ],
        ),
      ),
    );
  }
}
