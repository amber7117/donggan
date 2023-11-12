import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_model.dart';
import 'package:wzty/modules/match/service/match_detail_lineup_service.dart';
import 'package:wzty/modules/match/widget/lineup/match_lineup_coach_widget.dart';
import 'package:wzty/modules/match/widget/lineup/match_lineup_player_widget.dart';
import 'package:wzty/modules/match/widget/lineup/match_lineup_referee_widget.dart';
import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchLineupFbHeadWidget extends StatefulWidget {
  final MatchLineupFBModel model;
  final bool isHost;
  final bool uncoming;
  final MatchDetailModel detailModel;

  const MatchLineupFbHeadWidget(
      {super.key,
      required this.model,
      required this.isHost,
      required this.uncoming,
      required this.detailModel});

  @override
  State createState() => _MatchLineupFbHeadWidgetState();
}

class _MatchLineupFbHeadWidgetState extends State<MatchLineupFbHeadWidget> {
  void _requestPlayerData(MatchLineupFBPlayerModel player) {
    ToastUtils.showLoading();

    MatchDetailLineupService.requestFBPlayerInfo(
        widget.detailModel.matchId, player.teamId, player.playerId,
        (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        showDialog(
            context: context,
            builder: (context) {
              return MatchLineupPlayerWidget(
                  model: result,
                  callback: () {
                    Navigator.pop(context);
                  });
            });
      } else {
        ToastUtils.showInfo(result);
      }
    });
  }

  void _requestCoachData() {
    ToastUtils.showLoading();

    MatchLineupFBModel model = widget.model;
    int teamId = model.hostTeamId;
    int coachId = model.hostCoachId;
    if (!widget.isHost) {
      teamId = model.guestTeamId;
      coachId = model.guestCoachId;
    }

    MatchDetailLineupService.requestFBCoachInfo(
        widget.detailModel.matchId, teamId, coachId, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        showDialog(
            context: context,
            builder: (context) {
              return MatchLineupCoachWidget(
                  model: result,
                  callback: () {
                    Navigator.pop(context);
                  });
            });
      } else {
        ToastUtils.showInfo(result);
      }
    });
  }

  void _requestRefereeData() {
    ToastUtils.showLoading();

    MatchLineupFBModel model = widget.model;

    MatchDetailLineupService.requestFBRefereeInfo(
        widget.detailModel.matchId, model.refereeId, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        showDialog(
            context: context,
            builder: (context) {
              return MatchLineupRefereeWidget(
                  model: result,
                  callback: () {
                    Navigator.pop(context);
                  });
            });
      } else {
        ToastUtils.showInfo(result);
      }
    });
  }

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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.isHost
                      ? _buildFormationUI(
                          model.hostFormation, model.hostMainPlayerList!)
                      : _buildFormationUI(
                          model.guestFormation, model.guestMainPlayerList!),
                ),
                InkWell(
                  onTap: _requestRefereeData,
                  child: Container(
                    width: 106,
                    height: 22,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5),
                        const JhAssetImage(
                            "match/iconZuqiushijianBisaikaishi10",
                            width: 10),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            model.refereeName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoUI() {
    MatchLineupFBModel model = widget.model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                    buildNetImage(
                        widget.isHost
                            ? model.hostTeamLogo
                            : model.guestTeamLogo,
                        width: 20,
                        placeholder: "common/logoQiudui"),
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
                      widget.isHost
                          ? model.hostFormation
                          : model.guestFormation,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: TextStyleUtils.medium),
                    ),
                  ],
                )),
            Expanded(
              child: Text(
                widget.uncoming ? "当前为预测首发阵容" : "当前为官方首发名单",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: TextStyleUtils.regual),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
        InkWell(
          onTap: _requestCoachData,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 5),
            child: Text(
              widget.isHost
                  ? "教练：${model.hostCoachName}"
                  : "教练：${model.guestCoachName}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
        ),
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

    return InkWell(
      onTap: () {
        _requestPlayerData(player);
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
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
          ),
          _buildEventUI(player),
        ],
      ),
    );
  }

  Widget _buildEventUI(MatchLineupFBPlayerModel model) {
    List<Widget> rowChildren = [];
    List<Widget> resetTypeChildren = [];
    for (MatchLineupFBEventModel eventModel in model.eventList) {
      String imgPath1 =
          AppBusinessUtils.obtainLineupEventPic(eventModel.resetTypeId);
      if (imgPath1.isEmpty) {
        continue;
      }

      if (eventModel.resetTypeId == 8 || eventModel.resetTypeId == 9) {
        Widget img = JhAssetImage(imgPath1, width: 12);
        resetTypeChildren.add(img);

        Widget label = Text(
          "${eventModel.time ~/ 60}'",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: TextStyleUtils.regual),
        );
        resetTypeChildren.add(label);
      } else {
        Widget img = JhAssetImage(imgPath1, width: 12);
        rowChildren.add(img);
      }
    }

    if (resetTypeChildren.isNotEmpty && rowChildren.isNotEmpty) {
      return Column(
        children: [
          Container(
            width: 34,
            height: 14,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.4),
                    Color.fromRGBO(0, 0, 0, 0.2),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: resetTypeChildren,
            ),
          ),
          Row(
            children: rowChildren,
          )
        ],
      );
    } else {
      if (resetTypeChildren.isNotEmpty) {
        return Container(
          width: 34,
          height: 14,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.4),
                  Color.fromRGBO(0, 0, 0, 0.2),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: resetTypeChildren,
          ),
        );
      } else if (rowChildren.isNotEmpty) {
        return Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 25,
              child: Row(
                children: rowChildren,
              ),
            ),
          ],
        );
      } else {
        return const SizedBox();
      }
    }
  }
}
