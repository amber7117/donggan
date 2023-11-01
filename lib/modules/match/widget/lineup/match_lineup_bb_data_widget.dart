import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_bb_model.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchLineupBBDataWidget extends StatefulWidget {
  final MatchLineupBBModel model;

  const MatchLineupBBDataWidget({super.key, required this.model});

  @override
  State createState() => _MatchLineupBBDataWidgetState();
}

class _MatchLineupBBDataWidgetState extends State<MatchLineupBBDataWidget> {
  @override
  Widget build(BuildContext context) {
    MatchLineupBBModel model = widget.model;
    List<List<MatchLineupBBPlayerModel>> mvpList2 = model.mvpList2;
    return SizedBox(
      height: 294,
      child: Column(children: [
        _buildTeamWidget(model),
        const SizedBox(height: 15),
        _buildDataWidget("得分", mvpList2[0]),
        const SizedBox(height: 15),
        _buildDataWidget("篮板", mvpList2[1]),
        const SizedBox(height: 15),
        _buildDataWidget("助攻", mvpList2[2]),
      ]),
    );
  }

  _buildTeamWidget(MatchLineupBBModel model) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        children: [
          const SizedBox(width: 10),
          buildNetImage(model.hostTeam.teamLogo,
              width: 20, placeholder: "common/logoQiudui"),
          const SizedBox(width: 5),
          SizedBox(
            width: 100,
            child: Text(
              model.hostTeam.teamName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: 100,
            child: Text(
              model.hostTeam.teamName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
          const SizedBox(width: 5),
          buildNetImage(model.hostTeam.teamLogo,
              width: 20, placeholder: "common/logoQiudui"),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  _buildDataWidget(String title, List<MatchLineupBBPlayerModel> mvpList) {
    MatchLineupBBPlayerModel player1 = mvpList.first;
    MatchLineupBBPlayerModel player2 = mvpList.last;
    int team1 = 0;
    int team2 = 0;
    if (title == "得分") {
      team1 = player1.point;
      team2 = player2.point;
    } else if (title == "篮板") {
      team1 = player1.rebound;
      team2 = player2.rebound;
    } else if (title == "助攻") {
      team1 = player1.assist;
      team2 = player2.assist;
    }

    return SizedBox(
      width: double.infinity,
      height: 64,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          buildNetImage(player1.picUrl,
              width: 64, placeholder: "common/logoQiuyuan"),
          const SizedBox(width: 8),
          SizedBox(
            width: 210.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildProgressDataWidget(title, team1, team2),
                const SizedBox(height: 5),
                _buildProgressWidget(team1, team2),
                const SizedBox(height: 3),
                _buildNameWidget(player1.name, player2.name),
              ],
            ),
          ),
          const SizedBox(width: 8),
          buildNetImage(player2.picUrl,
              width: 64, placeholder: "common/logoQiuyuan"),
          const SizedBox(width: 10),
        ],
      ),
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
    Color team1Color = ColorUtils.red233;
    Color team2Color = ColorUtils.blue66;

    double width = 200.w;
    double widthHalf = width * 0.5;
    double team1Width = 0.0;
    double team2Width = 0.0;
    if (team1 > 0 || team2 > 0) {
      team1Width = widthHalf * (team1 / (team1 + team2));
      team2Width = widthHalf * (team2 / (team1 + team2));
    }

    return SizedBox(
      width: 210.w,
      height: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: widthHalf,
              alignment: Alignment.centerLeft,
              color: ColorUtils.gray248,
              child:
                  SizedBox(width: team1Width, height: 6).colored(team1Color)),
          Container(
              width: widthHalf,
              alignment: Alignment.centerRight,
              color: ColorUtils.gray248,
              child:
                  SizedBox(width: team2Width, height: 6).colored(team2Color)),
        ],
      ),
    );
  }

  _buildNameWidget(String name1, String name2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name1,
            style: const TextStyle(
                color: Color.fromRGBO(30, 30, 30, 1.0),
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text(name2,
            style: const TextStyle(
                color: Color.fromRGBO(30, 30, 30, 1.0),
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }
}
