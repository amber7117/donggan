import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchAnalysisHistoryFootWidget extends StatelessWidget {
  final SportType sportType;
  final MatchAnalysisHistoryModel model;
  final bool isHost;
  final String logo;
  final String team;

  const MatchAnalysisHistoryFootWidget(
      {super.key,
      required this.sportType,
      required this.model,
      required this.logo,
      required this.team,
      this.isHost = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];

    Widget logoWidget =
        buildNetImage(logo, width: 20, placeholder: "common/logoQiudui");
    children.add(logoWidget);
    children.add(const SizedBox(width: 5));

    Widget teamWidget = Text(
      team,
      style: const TextStyle(
          color: ColorUtils.gray153,
          fontSize: 10,
          fontWeight: TextStyleUtils.regual),
    );

    children.add(teamWidget);
    children.add(const SizedBox(width: 5));

    if (sportType == SportType.football) {
      if (isHost) {
        children.addAll(_buildChidItem2(
            "${model.hostWinNum}", ColorUtils.red255, "胜", ColorUtils.gray153));
        children.add(const SizedBox(width: 5));

        children.addAll(_buildChidItem2("${model.hostDrawNum}",
            ColorUtils.gray153, "平", ColorUtils.gray153));
        children.add(const SizedBox(width: 5));

        children.addAll(_buildChidItem2("${model.hostLoseNum}",
            ColorUtils.green0, "负", ColorUtils.gray153));
        children.add(const SizedBox(width: 5));
      } else {
        children.addAll(_buildChidItem2(
            "${model.winNum}", ColorUtils.red255, "胜", ColorUtils.gray153));
        children.add(const SizedBox(width: 5));

        children.addAll(_buildChidItem2(
            "${model.drawNum}", ColorUtils.gray153, "平", ColorUtils.gray153));
        children.add(const SizedBox(width: 5));

        children.addAll(_buildChidItem2(
            "${model.loseNum}", ColorUtils.green0, "负", ColorUtils.gray153));
        children.add(const SizedBox(width: 5));
      }

      children.addAll(_buildChidItem3("${model.hostScore}", ColorUtils.red255,
          "进", "球", ColorUtils.gray153));
      children.add(const SizedBox(width: 5));

      children.addAll(_buildChidItem3("${model.guestScore}", ColorUtils.green0,
          "失", "球", ColorUtils.gray153));
    } else {}

    return children;
  }

  _buildChidItem2(
      String value, Color valueColor, String title, Color titleColor) {
    Widget text1 = Text(
      value,
      style: TextStyle(
          color: valueColor, fontSize: 10, fontWeight: TextStyleUtils.regual),
    );
    Widget text2 = Text(
      title,
      style: TextStyle(
          color: titleColor, fontSize: 10, fontWeight: TextStyleUtils.regual),
    );
    return [text1, text2];
  }

  _buildChidItem3(String value, Color valueColor, String title1, String title2,
      Color titleColor) {
    Widget text0 = Text(
      title1,
      style: TextStyle(
          color: titleColor, fontSize: 10, fontWeight: TextStyleUtils.regual),
    );
    Widget text1 = Text(
      value,
      style: TextStyle(
          color: valueColor, fontSize: 10, fontWeight: TextStyleUtils.regual),
    );
    Widget text2 = Text(
      title2,
      style: TextStyle(
          color: titleColor, fontSize: 10, fontWeight: TextStyleUtils.regual),
    );
    return [text0, text1, text2];
  }
}
