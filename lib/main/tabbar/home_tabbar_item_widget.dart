
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class NewsTabbarItemWidget extends StatelessWidget {

  final String tabName;

  final int index;

  const NewsTabbarItemWidget({super.key, required this.tabName, required this.index});
  
  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Container(
            margin: const EdgeInsets.only(left: 2, right: 2),
            padding: const EdgeInsets.only(top: 10),
            width: 60.0,
            height: 40.0,
            decoration: context.watch<NewsTabProvider>().index == index
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
            )));
  }
}

