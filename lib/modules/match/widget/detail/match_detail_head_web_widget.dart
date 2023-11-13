import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/webview/wz_webview_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';

class MatchDetailHeadWebWidget extends StatelessWidget {
  final double height;
  final String urlStr;

  const MatchDetailHeadWebWidget(
      {super.key, required this.height, required this.urlStr});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + ScreenUtil().statusBarHeight,
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: height,
                child: WZWebviewWidget(urlStr: urlStr),
              ),
              const WZBackButton(),
            ],
          )
        ],
      ),
    );
  }
}
