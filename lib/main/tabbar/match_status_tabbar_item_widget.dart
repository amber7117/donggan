import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const matchStatusItemWidth = 108.0;

class MatchStatusTabbarItemWidget extends StatelessWidget {
  final String tabName;

  final double tabWidth;
  final double tabHeight;

  final int index;

  const MatchStatusTabbarItemWidget(
      {super.key,
      required this.tabName,
      this.tabWidth = 108.0,
      this.tabHeight = 28.0,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Tab(
        height: tabHeight,
        child: Container(
            width: tabWidth,
            height: tabHeight,
            alignment: Alignment.center,
            decoration: context.watch<TabProvider>().index == index
                ? BoxDecoration(
                    color: ColorUtils.red233,
                    borderRadius:
                        BorderRadius.all(Radius.circular(tabHeight * 0.5)))
                : const BoxDecoration(),
            child: Text(
              tabName,
              textAlign: TextAlign.center,
              style: context.watch<TabProvider>().index == index
                  ? const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual)
                  : const TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.medium),
            )));
  }
}
