import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';

class MatchDetailHeadVoteWidget extends StatelessWidget {
  const MatchDetailHeadVoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int team1 = 80;
    int team2 = 20;

    double width = 200.w;
    double team1Width = 0.0;
    double team2Width = 0.0;
    if (team1 > 0 || team2 > 0) {
      team1Width = width * (team1 / (team1 + team2));
      team2Width = width * (team2 / (team1 + team2));
    }

    return Container(
      width: width,
      color: Colors.yellow,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: team1Width, height: 8).decorate(
            const BoxDecoration(
                color: ColorUtils.red233,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4))),
          ),
          SizedBox(width: team2Width, height: 8).decorate(
            const BoxDecoration(
                color: ColorUtils.blue66,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4))),
          ),
        ],
      ),
    );
  }
}
