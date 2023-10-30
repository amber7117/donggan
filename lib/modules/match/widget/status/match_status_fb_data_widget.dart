import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusFBDataWidget extends StatefulWidget {
  final MatchStatusFBTechModel? model;

  const MatchStatusFBDataWidget({super.key, this.model});

  @override
  State createState() => _MatchStatusFBDataWidgetState();
}

class _MatchStatusFBDataWidgetState extends State<MatchStatusFBDataWidget> {
  @override
  Widget build(BuildContext context) {
    MatchStatusFBTechModel? model = widget.model;
    
    int goalKicksTeam1 = model?.goalKicks?.team1 ?? 0;
    int goalKicksTeam2 = model?.goalKicks?.team2 ?? 0;
    int shootOnGoalTeam1 = model?.shootOnGoal?.team1 ?? 0;
    int shootOnGoalTeam2 = model?.shootOnGoal?.team2 ?? 0;
    return SizedBox(
      width: double.infinity,
      height: 86,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPaiWidget("event/iconZuqiushijianJiaoqiu12",
              (model?.cornerKicks?.team1 ?? 0)),
          _buildPaiWidget(
              "event/iconZuqiushijianHngpai12", (model?.redCards?.team1 ?? 0)),
          _buildPaiWidget("event/iconZuqiushijianHuangpai12",
              (model?.yellowCards?.team1 ?? 0)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProgressDataWidget("射门", goalKicksTeam1, goalKicksTeam2),
              const SizedBox(height: 5),
              _buildProgressWidget(goalKicksTeam1, goalKicksTeam2),
              const SizedBox(height: 10),
              _buildProgressDataWidget(
                  "射正", shootOnGoalTeam1, shootOnGoalTeam2),
              const SizedBox(height: 5),
              _buildProgressWidget(shootOnGoalTeam1, shootOnGoalTeam2),
            ],
          ),
          _buildPaiWidget("event/iconZuqiushijianHuangpai12",
              (model?.yellowCards?.team2 ?? 0)),
          _buildPaiWidget(
              "event/iconZuqiushijianHngpai12", (model?.redCards?.team2 ?? 0)),
          _buildPaiWidget("event/iconZuqiushijianJiaoqiu12",
              (model?.cornerKicks?.team2 ?? 0)),
        ],
      ),
    );
  }

  _buildPaiWidget(String imgPath, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        JhAssetImage(imgPath, width: 12),
        const SizedBox(height: 15),
        Text("$value",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }

  _buildProgressDataWidget(String title, int team1, int team2) {
    Color team1Color;
    Color team2Color;
    if (team1 > team2) {
      team1Color = ColorUtils.black34;
      team2Color = ColorUtils.gray153;
    } else if (team1 < team2) {
      team1Color = ColorUtils.gray153;
      team2Color = ColorUtils.black34;
    } else {
      team1Color = ColorUtils.black34;
      team2Color = ColorUtils.black34;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$team1",
            style: TextStyle(
                color: team1Color,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text(title,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text("$team2",
            style: TextStyle(
                color: team2Color,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }

  _buildProgressWidget(int team1, int team2) {
    Color team1Color;
    Color team2Color;
    if (team1 > team2) {
      team1Color = const Color.fromRGBO(233, 78, 78, 1.0);
      team2Color = const Color.fromRGBO(66, 191, 244, 0.2);
    } else if (team1 < team2) {
      team1Color = const Color.fromRGBO(233, 78, 78, 0.2);
      team2Color = const Color.fromRGBO(66, 191, 244, 1.0);
    } else {
      team1Color = const Color.fromRGBO(233, 78, 78, 1.0);
      team2Color = const Color.fromRGBO(66, 191, 244, 1.0);
    }
    double width = 187.w;
    double widthHalf = width * 0.5;
    double team1Width = 0.0;
    double team2Width = 0.0;
    if (team1 > 0 || team2 > 0) {
      team1Width = widthHalf * (team1 / (team1 + team2));
      team2Width = widthHalf * (team2 / (team1 + team2));
    }

    return Container(
      width: width,
      height: 6,
      decoration: const BoxDecoration(
          color: ColorUtils.gray248,
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: widthHalf,
              alignment: Alignment.centerRight,
              child: SizedBox(width: team1Width, height: 6).decorate(
                BoxDecoration(
                    color: team1Color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3))),
              )),
          Container(
              width: widthHalf,
              alignment: Alignment.centerLeft,
              child: SizedBox(width: team2Width, height: 6).decorate(
                BoxDecoration(
                    color: team2Color,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3))),
              )),
        ],
      ),
    );
  }
}
