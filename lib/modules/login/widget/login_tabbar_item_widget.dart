

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/modules/news/provider/news_tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class LoginTabbarItemWidget extends StatelessWidget {

  final String tabName;

  final int index;

  const LoginTabbarItemWidget({super.key, required this.tabName, required this.index});
  
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Consumer<NewsTabProvider>(builder: (context, provider, child) {
        return Container(
            width: 169.5,
            height: 48.0,
            decoration: provider.index == index
                ? const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(252, 230, 230, 1.0),
                        Color.fromRGBO(255, 255, 255, 1.0)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)))
                : const BoxDecoration(),
            child: Column(
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
                    decoration: BoxDecoration(color: ColorUtils.red235),
                    child: SizedBox(height: 2, width: 30))
              ],
            ));
      }),
    );
  }

}