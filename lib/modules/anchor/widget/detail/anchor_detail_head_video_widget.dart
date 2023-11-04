import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/player/wz_player_page.dart';
import 'package:wzty/common/widget/wz_back_button.dart';

class AnchorDetailHeadVideoWidget extends StatefulWidget {
  final double height;
  final String urlStr;
  final bool isAnchor;

  const AnchorDetailHeadVideoWidget(
      {super.key,
      required this.height,
      required this.urlStr,
      this.isAnchor = true});

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
          SizedBox(width: double.infinity, height: ScreenUtil().statusBarHeight)
              .colored(Colors.black),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: widget.height,
                child: WZPlayerPage(
                    urlStr: widget.urlStr,
                    type: widget.isAnchor
                        ? WZPlayerType.anchor
                        : WZPlayerType.playback),
              ),
              const WZBackButton(),
            ],
          )
        ],
      ),
    );
  }
}
