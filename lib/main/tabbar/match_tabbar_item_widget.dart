import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const matchItemWidth = 54.0;

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
        height: tabHeight,
        child: SizedBox(
            width: tabWidth,
            height: tabHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _buildChildWidget(context),
            )));
  }

  _buildChildWidget(BuildContext context) {
    return context.watch<TabProvider>().index == index
        ? [
            Text(
              tabName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: ColorUtils.red233,
                  fontSize: 14,
                  fontWeight: TextStyleUtils.semibold),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 6.5),
              child: ColoredBox(
                  color: ColorUtils.red235,
                  child: SizedBox(height: 3, width: 28)),
            ),
          ]
        : [
            Text(
              tabName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromRGBO(102, 102, 102, 1.0),
                  fontSize: 14,
                  fontWeight: TextStyleUtils.medium),
            ),
            const SizedBox(height: 8.5),
          ];
  }
}
