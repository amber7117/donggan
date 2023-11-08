import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/player/wz_player_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';

class MatchDetailHeadVideoWidget extends StatefulWidget {
  final double height;
  final String urlStr;

  const MatchDetailHeadVideoWidget(
      {super.key, required this.height, required this.urlStr});

  @override
  State createState() => _MatchDetailHeadVideoWidgetState();
}

class _MatchDetailHeadVideoWidgetState
    extends State<MatchDetailHeadVideoWidget> {
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
                child: WZPlayerWidget(urlStr: widget.urlStr, type: WZPlayerType.match),
              ),
              const WZBackButton(),
            ],
          )
        ],
      ),
    );
  }
}
