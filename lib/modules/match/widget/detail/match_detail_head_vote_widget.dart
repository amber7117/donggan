import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/match_vote_entity.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailHeadVoteWidget extends StatefulWidget {
  final MatchDetailModel model;

  const MatchDetailHeadVoteWidget({super.key, required this.model});

  @override
  State createState() => _MatchDetailHeadVoteWidgetState();
}

class _MatchDetailHeadVoteWidgetState extends State<MatchDetailHeadVoteWidget> {
  MatchVoteEntity? _model;

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    MatchDetailService.requestMatchVoteData(widget.model.matchId,
        (success, result) {
      if (success) {
        _model = result;
        setState(() {});
      }
    });
  }

  _requestVote(bool isHost) {
    MatchStatus matchStatus =
        matchStatusFromServerValue(widget.model.matchStatus);
    if (matchStatus == MatchStatus.going) {
      ToastUtils.showInfo("比赛已经开始啦");
      return;
    } else if (matchStatus == MatchStatus.finished) {
      ToastUtils.showInfo("比赛已经结束啦");
      return;
    }

    if (!UserManager.instance.isLogin()) {
      Routes.goLoginPage(context);
      return false;
    }

    if (_model!.isHight.isTrue()) return;
    int voteType = isHost ? 1 : 2;
    ToastUtils.showLoading();
    MatchDetailService.requestMatchVote(widget.model.matchId, voteType,
        (success, result) {
      ToastUtils.hideLoading();
      if (result.isNotEmpty) {
        ToastUtils.showError(result);
      } else {
        ToastUtils.showSuccess("投票成功");
        _model!.isHight = 1;
        _model!.type = voteType;

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }

    MatchVoteEntity model = _model!;

    int team1 = model.homeTeam;
    int team2 = model.awayTeam;

    double width = 200.w;
    double team1Width = 0.0;
    double team2Width = 0.0;
    if (team1 > 0 || team2 > 0) {
      team1Width = width * (team1 / (team1 + team2));
      team2Width = width * (team2 / (team1 + team2));
    }

    bool voteHost = model.type == 1;
    bool voteGuest = model.type == 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              _requestVote(true);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: JhAssetImage(
                  voteHost ? "match/iconVoteL2" : "match/iconVoteL",
                  width: 28),
            )),
        Text(
          "${model.homeTeam}%",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
        ),
        Container(
          width: width,
          height: 20,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,            
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
        ),
        Text(
          "${model.awayTeam}%",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
        ),
        InkWell(
            onTap: () {
              _requestVote(false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: JhAssetImage(
                  voteGuest ? "match/iconVoteR2" : "match/iconVoteR",
                  width: 28),
            )),
      ],
    );
  }
}
