import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

AppBar buildAppBar({
  final Color? backIconColor,
  final Widget? leading,
  final double? leadingWidth,
  final Widget? trailing,
  final Widget? title,
  final String? titleText,
  final double? titleTextFontSize,
  final Color? titleTextColor,
  final Color? backgroundColor,
  final VoidCallback? onBackPressed,
}) {
  return AppBar(
      leadingWidth: leadingWidth,
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      leading: leading ??
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: backIconColor ?? ColorUtils.black34,
                ),
                iconSize: 24,
                onPressed: onBackPressed ?? () => Navigator.maybePop(context),
              );
            },
          ),
      title: title ??
          Text(
            titleText ?? '',
            style: TextStyle(
              color: titleTextColor ?? ColorUtils.black34,
              fontSize: titleTextFontSize ?? 16,
              fontWeight: TextStyleUtils.bold,
            ),
          ),
      actions: trailing != null ? [trailing] : null,
      bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 0.5),
          child: Container(color: ColorUtils.gray248, height: 1.0)));
}

Widget buildCustomAppBar({
  required BuildContext context,
  required String titleText,
  double height = 56,
}) {
  return Container(
    height: height,
    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: Container(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorUtils.black34,
                ),
                iconSize: 24,
                onPressed: () => Navigator.maybePop(context),
              );
            },
          ),
          Center(
            child: Text(
              titleText,
              style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 16,
                fontWeight: TextStyleUtils.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
