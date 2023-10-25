import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/webview/wz_webview_page.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MatchDetailHeadWebWidget extends StatefulWidget {
  final double height;
  final String urlStr;

  const MatchDetailHeadWebWidget(
      {super.key, required this.height, required this.urlStr});

  @override
  State createState() => _MatchDetailHeadWebWidgetState();
}

class _MatchDetailHeadWebWidgetState extends State<MatchDetailHeadWebWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height + ScreenUtil().statusBarHeight,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image:
                  JhImageUtils.getAssetImage("match/imgZuqiuBg", x2: false))),
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: widget.height,
                child: WZWebviewPage(urlStr: widget.urlStr),
              ),
              const WZBackButton(),
            ],
          )
        ],
      ),
    );
  }
}
