import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/player/wz_player_page.dart';
import 'package:wzty/common/widget/wz_back_button.dart';

class AnchorDetailHeadVideoWidget extends StatefulWidget {
  final double height;
  final String urlStr;

  const AnchorDetailHeadVideoWidget(
      {super.key, required this.height, required this.urlStr});

  @override
  State createState() => _AnchorDetailHeadVideoWidgetState();
}

class _AnchorDetailHeadVideoWidgetState
    extends State<AnchorDetailHeadVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height + ScreenUtil().statusBarHeight,
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: widget.height,
                child: WZPlayerPage(
                    urlStr: widget.urlStr, type: WZPlayerType.anchor),
              ),
              const WZBackButton(),
            ],
          )
        ],
      ),
    );
  }
}
