import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';

class WZSureSizeButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback handleTap;
  final bool enable;

  const WZSureSizeButton({
    super.key,
    required this.title,
    required this.handleTap,
    required this.width,
    required this.height,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? handleTap : null,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: enable
                  ? [
                      ColorUtils.red233,
                      ColorUtils.red217,
                    ]
                  : [
                      ColorUtils.red233.withOpacity(0.5),
                      ColorUtils.red217.withOpacity(0.5),
                    ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(height * 0.5))),
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
