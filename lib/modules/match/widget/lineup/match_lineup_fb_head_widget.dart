import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_model.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchLineupFbHeadWidget extends StatefulWidget {
  final MatchLineupFBModel model;
  final bool isHost;

  const MatchLineupFbHeadWidget(
      {super.key, required this.model, required this.isHost});

  @override
  State createState() => _MatchLineupFbHeadWidgetState();
}

class _MatchLineupFbHeadWidgetState extends State<MatchLineupFbHeadWidget> {
  @override
  Widget build(BuildContext context) {
    MatchLineupFBModel model = widget.model;

    return Container(
      height: 519,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: JhImageUtils.getAssetImage("match/bgLineup", x2: false),
            fit: BoxFit.fitWidth),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildInfoUI(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.isHost
                  ? _buildFormationUI(
                      model.hostFormation, model.hostMainPlayerList!)
                  : _buildFormationUI(
                      model.guestFormation, model.guestMainPlayerList!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoUI() {
    bool isHost = widget.isHost;
    MatchLineupFBModel model = widget.model;

    return Row(
      children: [
        const SizedBox(width: 12),
        Container(
            width: 150,
            height: 28,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.3),
                    Color.fromRGBO(0, 0, 0, 0.0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(14))),
            child: Row(
              children: [
                const SizedBox(width: 10),
                buildNetImage(isHost ? model.hostTeamLogo : model.guestTeamLogo,
                    width: 20, placeholder: "common/logoQiudui"),
                const SizedBox(width: 5),
                const Text(
                  "阵型：",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual),
                ),
                Text(
                  isHost ? model.hostFormation : model.guestFormation,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.medium),
                ),
              ],
            )),
        const Expanded(
          child: Text(
            "当前为预测首发阵容",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  List<Widget> _buildFormationUI(
      String formation, List<MatchLineupFBPlayerModel> playerList) {
    if (formation.length < 3 || playerList.isEmpty) {
      return [];
    }

    String formationStr = "1-$formation";
    List<String> formationNumArr = formationStr.split("-");

    // if (widget.type == MatchLineupFBHeadType.guest) {
    //   formationNumArr = formationNumArr.reversed.toList();
    // }

    List<Widget> rowWidgetArr = [];

    int formationNumArrCnt = formationNumArr.length;

    int i = -1;

    for (int idx = 0; idx < formationNumArrCnt; idx++) {
      int formationNum = int.parse(formationNumArr[idx]);

      List<Widget> rowChildren = [];

      for (int _ = 0; _ < formationNum; _++) {
        i++;

        if (i >= playerList.length) {
          break;
        }

        MatchLineupFBPlayerModel playerModel = playerList[i];
        rowChildren.add(_buildPlayerWidget(playerModel));
      }

      Widget row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowChildren,
      );

      rowWidgetArr.add(row);
    }

    return rowWidgetArr;
  }

  Widget _buildPlayerWidget(MatchLineupFBPlayerModel player) {
    String imgPath;
    if (widget.isHost) {
      imgPath = "match/iconPlayerRed";
    } else {
      imgPath = "match/iconPlayerBlue";
    }

    return SizedBox(
      width: 80,
      height: 60,
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: JhImageUtils.getAssetImage(imgPath),
                  fit: BoxFit.fitWidth),
            ),
            child: Text(
              player.shirtNumber,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.medium),
            ),
          ),
          Text(
            player.playerName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ],
      ),
    );
  }
}
