import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_bb_model.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double lineupBBPlayInfoWidth = 136.0;
const double lineupBBTeamInfoHeight = 40.0;
const double lineupBBListItemWidth = 50.0;
const double lineupBBListItemHeight = 36.0;

class MatchLineupBBListWidget extends StatefulWidget {
  final MatchLineupBBTeamModel team;
  final List<List<String>> dataArr2;

  const MatchLineupBBListWidget(
      {super.key, required this.team, required this.dataArr2});

  @override
  State createState() => _MatchLineupBBListWidgetState();
}

class _MatchLineupBBListWidgetState extends State<MatchLineupBBListWidget> {
  @override
  Widget build(BuildContext context) {
    MatchLineupBBTeamModel team = widget.team;
    List<List<String>> dataArr2 = widget.dataArr2;

    double listHeight = (team.playerStats.length + 1) * lineupBBListItemHeight +
        lineupBBTeamInfoHeight +
        10;

    return SizedBox(
      height: listHeight,
      child: Column(
        children: [
          const SizedBox(width: double.infinity, height: 10)
              .colored(ColorUtils.gray248),
          _buildTeamWidget(team.teamLogo, team.teamName),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: lineupBBPlayInfoWidth,
                  child: Column(
                    children: _buildPlayerUI(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: dataArr2.length,
                      itemExtent: lineupBBListItemWidth,
                      itemBuilder: (context, index) {
                        return Column(
                            children: _buildCellItem(
                          dataArr2[index],
                        ));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTeamWidget(String logo, String team) {
    return SizedBox(
      width: double.infinity,
      height: lineupBBTeamInfoHeight,
      child: Row(
        children: [
          const SizedBox(width: 10),
          buildNetImage(logo, width: 20, placeholder: "common/logoQiudui"),
          const SizedBox(width: 5),
          SizedBox(
            width: 100,
            child: Text(
              team,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
        ],
      ),
    );
  }

  _buildPlayerUI() {
    List<Widget> children = [];

    Widget header = Container(
      width: lineupBBPlayInfoWidth,
      height: lineupBBListItemHeight,
      alignment: Alignment.center,
      color: ColorUtils.gray248,
      child: const Text("#  球员",
          style: TextStyle(
              color: ColorUtils.black34,
              fontSize: 11,
              fontWeight: TextStyleUtils.regual)),
    );
    children.add(header);

    MatchLineupBBTeamModel team = widget.team;
    for (MatchLineupBBPlayerModel player in team.playerStats) {
      Widget playerItem = _buildPlayerItem(player);
      children.add(playerItem);
    }
    return children;
  }

  _buildPlayerItem(MatchLineupBBPlayerModel player) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: ColorUtils.red233,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(
            player.shirtNumber,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 88,
          height: lineupBBListItemHeight,
          alignment: Alignment.center,
          child: Text(
            player.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
        )
      ],
    );
  }

  _buildCellItem(List<String> dataArr) {
    List<Widget> children = [];
    Widget header = Container(
      width: lineupBBListItemWidth,
      height: lineupBBListItemHeight,
      color: ColorUtils.gray248,
      alignment: Alignment.center,
      child: Text(
        dataArr.first,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: ColorUtils.black34,
            fontSize: 12,
            fontWeight: TextStyleUtils.regual),
      ),
    );
    children.add(header);

    for (int i = 1; i < dataArr.length; i++) {
      Widget child = Container(
        width: lineupBBListItemWidth,
        height: lineupBBListItemHeight,
        alignment: Alignment.center,
        child: Text(dataArr[i],
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 11,
                fontWeight: TextStyleUtils.regual)),
      );
      children.add(child);
    }
    return children;
  }
}
