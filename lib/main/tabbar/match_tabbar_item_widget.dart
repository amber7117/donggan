import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchTabbarItemWidget extends StatelessWidget {
  final String tabName;

  final double tabWidth;
  final double tabHeight;

  final int index;

  const MatchTabbarItemWidget(
      {super.key,
      required this.tabName,
      this.tabWidth = 54.0,
      this.tabHeight = 40.0,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Container(
            margin: const EdgeInsets.only(left: 2, right: 2),
            padding: const EdgeInsets.only(top: 10),
            width: tabWidth,
            height: tabHeight,
            child: Column(
              children: _buildChildWidget(context),
            )));
  }

  _buildChildWidget(BuildContext context) {
    return context.watch<TabProvider>().index == index
        ? [
            Text(
              tabName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtils.red233,
                  fontSize: 14.sp,
                  fontWeight: TextStyleUtils.semibold),
            ),
            const DecoratedBox(
                decoration: BoxDecoration(color: ColorUtils.red233),
                child: SizedBox(height: 3, width: 28))
          ]
        : [
            Text(
              tabName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color.fromRGBO(102, 102, 102, 1.0),
                  fontSize: 14.sp,
                  fontWeight: TextStyleUtils.medium),
            ),
            const SizedBox()
          ];
  }
}
