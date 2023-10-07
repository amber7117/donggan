import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/modules/match/entity/match_info_entity.dart';
import 'package:wzty/modules/match/manager/match_collect_manager.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

const double matchChildCellHeight = 105.0;
const double _teamW = 120.0;
const double _textW = 26.0;

class MatchChildCellWidget extends StatefulWidget {
  final SportType sportType;
  final MatchInfoModel model;
  final bool isCollectCell;

  const MatchChildCellWidget(
      {super.key,
      required this.sportType,
      required this.model,
      this.isCollectCell = false});

  @override
  State createState() => _MatchChildCellWidgetState();
}

class _MatchChildCellWidgetState extends State<MatchChildCellWidget> {
  _requestMatchCollect() {
    MatchInfoModel model = widget.model;
    bool isAdd = !model.focus;

    ToastUtils.showLoading();

    MatchService.requestMatchCollect(widget.sportType, model.matchId, isAdd,
        (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        ToastUtils.showSuccess(isAdd ? "收藏成功" : "取消收藏成功");
        model.focus = isAdd;

        MatchCollectManager.instance.updateCollectData(widget.sportType, model);

        setState(() {});
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MatchInfoModel model = widget.model;
    MatchStatus matchStatus = matchStatusFromServerValue(model.status);
    bool showScore = (matchStatus == MatchStatus.going ||
        matchStatus == MatchStatus.finished);
    bool matchGoing = matchStatus == MatchStatus.going;
    bool matchFinished = matchStatus == MatchStatus.finished;

    return InkWell(
        onTap: () {
          Routes.push(context, Routes.matchDetail, arguments: model.matchId);
        },
        child: Container(
          height: matchChildCellHeight,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: _teamW,
                    child: Text(
                      model.leagueName,
                      style: TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 10.sp,
                          fontWeight: TextStyleUtils.medium),
                    ),
                  ),
                  Text(
                    _statusLabelText(matchStatus, model.timePlayed),
                    style: TextStyle(
                        color:
                            matchGoing ? ColorUtils.red235 : ColorUtils.gray153,
                        fontSize: 10.sp,
                        fontWeight: TextStyleUtils.medium),
                  ),
                  SizedBox(
                    width: _teamW,
                    child: Text(
                      model.matchTimeNew,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 10.sp,
                          fontWeight: TextStyleUtils.medium),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 0.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(253, 192, 200, 1.0),
                      Color.fromRGBO(200, 221, 253, 1.0),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: _teamW,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.hostTeamName,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 12.sp,
                              fontWeight: TextStyleUtils.semibold),
                        ),
                        Text(
                          model.guestTeamName,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 12.sp,
                              fontWeight: TextStyleUtils.semibold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(showScore ? "${model.hostTeamScore}" : "-",
                          style: _scoreLabelStyle(matchStatus,
                              model.hostTeamScore > model.guestTeamScore)),
                      Text(showScore ? "${model.guestTeamScore}" : "-",
                          style: _scoreLabelStyle(matchStatus,
                              model.hostTeamScore > model.guestTeamScore)),
                    ],
                  ),
                  SizedBox(
                    width: _teamW,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: (widget.isCollectCell || !matchFinished)
                            ? [
                                _animateWidget(model),
                                const SizedBox(width: 10),
                                Container(
                                    width: 1,
                                    height: 26,
                                    color: Colors.black.withOpacity(0.1)),
                                const SizedBox(width: 10),
                                _collectWidget(model.focus),
                              ]
                            : [
                                _animateWidget(model),
                              ]),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  _statusLabelText(MatchStatus matchStatus, String time) {
    if (matchStatus == MatchStatus.going) {
      return time;
    } else if (matchStatus == MatchStatus.finished) {
      return "完";
    } else {
      return "未";
    }
  }

  _scoreLabelStyle(MatchStatus matchStatus, bool winner) {
    if (matchStatus == MatchStatus.going) {
      return TextStyle(
          color: ColorUtils.red233,
          fontSize: 12.sp,
          fontWeight: TextStyleUtils.semibold);
    } else if (matchStatus == MatchStatus.finished) {
      if (winner) {
        return TextStyle(
            color: ColorUtils.red233,
            fontSize: 12.sp,
            fontWeight: TextStyleUtils.semibold);
      } else {
        return TextStyle(
            color: ColorUtils.black34,
            fontSize: 12.sp,
            fontWeight: TextStyleUtils.semibold);
      }
    } else {
      return TextStyle(
          color: ColorUtils.gray153,
          fontSize: 12.sp,
          fontWeight: TextStyleUtils.regual);
    }
  }

  _animateWidget(MatchInfoModel model) {
    if (ConfigManager.instance.videoOk &&
        (model.hasVid > 0 && model.hasLive > 0)) {
      return const JhAssetImage("match/iconMatchVideo", width: 24);
    } else if (ConfigManager.instance.animateOk && model.lmtMode > 0) {
      return const JhAssetImage("match/iconMatchAnimate", width: 24);
    } else {
      return const SizedBox(width: 24);
    }
  }

  _collectWidget(bool focus) {
    if (focus) {
      return InkWell(
        onTap: _requestMatchCollect,
        child: const JhAssetImage("match/iconMatchCollectS", width: 20),
      );
    } else {
      return InkWell(
        onTap: _requestMatchCollect,
        child: const JhAssetImage("match/iconMatchCollect", width: 20),
      );
    }
  }
}
