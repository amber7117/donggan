

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class LoginTabbarItemWidget extends StatelessWidget {

  final String tabName;

  final int index;

  const LoginTabbarItemWidget({super.key, required this.tabName, required this.index});
  
  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Container(
            width: 169.5,
            height: 48.0,
            decoration: context.watch<NewsTabProvider>().index == index
                ? const BoxDecoration(
                    color: Color.fromRGBO(255, 234, 234, 1.0),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)))
                : const BoxDecoration(),
            child: Column(
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
            )));
  }

}