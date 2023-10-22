import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const homeItemWidth = 56.0;

class HomeTabbarItemWidget extends StatelessWidget {
  final String tabName;

  final double tabWidth;
  final double tabHeight;

  final int index;

  const HomeTabbarItemWidget(
      {super.key,
      required this.tabName,
      this.tabWidth = 56.0,
      this.tabHeight = 40.0,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Tab(
        height: tabHeight,
        child: Container(
            width: tabWidth,
            height: tabHeight,
            decoration: context.watch<TabProvider>().index == index
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
                  color: ColorUtils.black34,
                  fontSize: 14,
                  fontWeight: TextStyleUtils.semibold),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 4),
              child: ColoredBox(
                  color: ColorUtils.red235,
                  child: SizedBox(height: 2, width: 32)),
            ),
          ]
        : [
            Text(
              tabName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromRGBO(248, 135, 152, 1.0),
                  fontSize: 14,
                  fontWeight: TextStyleUtils.medium),
            ),
            const SizedBox(height: 9.0),
          ];
  }
}
