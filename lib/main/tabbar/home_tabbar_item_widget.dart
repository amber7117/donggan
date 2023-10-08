import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/tabbar/home_tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class HomeTabbarItemWidget extends StatelessWidget {
  final String tabName;

  final double tabWidth;

  final int index;

  const HomeTabbarItemWidget(
      {super.key,
      required this.tabName,
      required this.tabWidth,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Container(
            margin: const EdgeInsets.only(left: 2, right: 2),
            padding: const EdgeInsets.only(top: 10),
            width: 60.0,
            height: 40.0,
            decoration: context.watch<HomeTabProvider>().index == index
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
              children: _buildChildWidget(context),
            )));
  }

  _buildChildWidget(BuildContext context) {
    return context.watch<HomeTabProvider>().index == index
        ? [
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
                child: SizedBox(height: 2, width: 32))
          ]
        : [
            Text(
              tabName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color.fromRGBO(248, 135, 152, 1.0),
                  fontSize: 14.sp,
                  fontWeight: TextStyleUtils.medium),
            ),
            const SizedBox()
          ];
  }
}

class HomeTabbarDotItemWidget extends StatelessWidget {
  final String tabName;

  final double tabWidth;

  final int index;

  const HomeTabbarDotItemWidget(
      {super.key,
      required this.tabName,
      required this.tabWidth,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 2, right: 2),
            padding: const EdgeInsets.only(top: 10),
            width: 60.0,
            height: 40.0,
            decoration: context.watch<HomeTabDotProvider>().index == index
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
              children: _buildChildWidget(context),
            )),
        _buildDotWidget(context),
      ],
    ));
  }

  _buildChildWidget(BuildContext context) {
    return context.watch<HomeTabDotProvider>().index == index
        ? [
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
                child: SizedBox(height: 2, width: 32))
          ]
        : [
            Text(
              tabName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color.fromRGBO(248, 135, 152, 1.0),
                  fontSize: 14.sp,
                  fontWeight: TextStyleUtils.medium),
            ),
            const SizedBox()
          ];
  }

  _buildDotWidget(BuildContext context) {
    HomeTabDotProvider provider = context.read<HomeTabDotProvider>();
    bool visible =
        (index == 3 && provider.dotNum > 0 && provider.index != index);
    return Visibility(
        visible: visible,
        child: Container(
          width: 25,
          height: 14,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Text(
            "${context.watch<HomeTabDotProvider>().dotNum}",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 8.sp,
                fontWeight: TextStyleUtils.semibold),
          ),
        ));
  }
}
