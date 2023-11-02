import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/entity/match_calendar_entity.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';
import 'package:wzty/modules/match/manager/match_collect_manager.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

const double matchChildCellHeight = 105.0;
const double _teamW = 120.0;
const double _textW = 26.0;

class MatchCellWidget extends StatefulWidget {
  final SportType? sportType;
  final MatchListModel? listModel;
  final MatchCalendarEntity? calendarEntity;
  final bool isCollectCell;

  const MatchCellWidget(
      {super.key,
      this.sportType,
      this.isCollectCell = false,
      this.listModel,
      this.calendarEntity});

  @override
  State createState() => _MatchCellWidgetState();
}

class _MatchCellWidgetState extends State<MatchCellWidget> {
  _prepareMatchOperate() {
    if (!UserManager.instance.isLogin()) {
      Routes.goLoginPage(context);
      return;
    }
    
    if (widget.listModel != null) {
      _requestMatchCollect();
    } else {
      _requestMatchBook();
    }
  }

  _requestMatchCollect() {
    MatchListModel model = widget.listModel!;
    bool isAdd = !model.focus;

    ToastUtils.showLoading();

    MatchService.requestMatchCollect(widget.sportType!, model.matchId, isAdd,
        (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        ToastUtils.showSuccess(isAdd ? "收藏成功" : "取消收藏成功");
        model.focus = isAdd;

        int cnt = MatchCollectManager.instance
            .updateCollectData(widget.sportType!, model);

        context.read<TabDotProvider>().setDotNum(cnt);

        setState(() {});
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  _requestMatchBook() {
    MatchCalendarEntity model = widget.calendarEntity!;
    bool isBook = !model.userIsAppointment;

    ToastUtils.showLoading();

    MatchService.requestMatchBook(model.matchId, isBook, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        ToastUtils.showSuccess(isBook ? "预约成功" : "取消预约成功");
        model.userIsAppointment = isBook;

        setState(() {});
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listModel != null) {
      return _buildListWidget(context, widget.listModel!);
    } else {
      return _buildCalendarWidget(context, widget.calendarEntity!);
    }
  }

  _buildListWidget(BuildContext context, MatchListModel model) {
    MatchStatus matchStatus = matchStatusFromServerValue(model.status);
    bool showScore = (matchStatus == MatchStatus.going ||
        matchStatus == MatchStatus.finished);
    bool matchGoing = matchStatus == MatchStatus.going;

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
                      style: const TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 10,
                          fontWeight: TextStyleUtils.medium),
                    ),
                  ),
                  Text(
                    _statusLabelText(matchStatus, model.timePlayed),
                    style: TextStyle(
                        color:
                            matchGoing ? ColorUtils.red235 : ColorUtils.gray153,
                        fontSize: 10,
                        fontWeight: TextStyleUtils.medium),
                  ),
                  SizedBox(
                    width: _teamW,
                    child: Text(
                      model.matchTimeNew,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 10,
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
                          style: const TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 12,
                              fontWeight: TextStyleUtils.semibold),
                        ),
                        Text(
                          model.guestTeamName,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 12,
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
                              model.hostTeamScore < model.guestTeamScore)),
                    ],
                  ),
                  SizedBox(
                    width: _teamW,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                            _buildAnimateCollectWidget(matchStatus, model)),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  _buildCalendarWidget(BuildContext context, MatchCalendarEntity model) {
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
                      model.tournamentName,
                      style: const TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 10,
                          fontWeight: TextStyleUtils.medium),
                    ),
                  ),
                  Text(
                    _statusLabelText(MatchStatus.uncoming, ""),
                    style: const TextStyle(
                        color: ColorUtils.gray153,
                        fontSize: 10,
                        fontWeight: TextStyleUtils.medium),
                  ),
                  SizedBox(
                    width: _teamW,
                    child: Text(
                      model.matchTimeNew,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: ColorUtils.gray153,
                          fontSize: 10,
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
                          style: const TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 12,
                              fontWeight: TextStyleUtils.semibold),
                        ),
                        Text(
                          model.guestTeamName,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 12,
                              fontWeight: TextStyleUtils.semibold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("-",
                          style: _scoreLabelStyle(MatchStatus.uncoming, true)),
                      Text("-",
                          style: _scoreLabelStyle(MatchStatus.uncoming, true)),
                    ],
                  ),
                  SizedBox(
                    width: _teamW,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: _prepareMatchOperate,
                        child: model.userIsAppointment
                            ? const JhAssetImage("match/iconMatchCollectS",
                                width: 20)
                            : const JhAssetImage("match/iconMatchCollect",
                                width: 20),
                      ),
                    ),
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
      return const TextStyle(
          color: ColorUtils.red233,
          fontSize: 12,
          fontWeight: TextStyleUtils.semibold);
    } else if (matchStatus == MatchStatus.finished) {
      if (winner) {
        return const TextStyle(
            color: ColorUtils.red233,
            fontSize: 12,
            fontWeight: TextStyleUtils.semibold);
      } else {
        return const TextStyle(
            color: ColorUtils.black34,
            fontSize: 12,
            fontWeight: TextStyleUtils.semibold);
      }
    } else {
      return const TextStyle(
          color: ColorUtils.gray153,
          fontSize: 12,
          fontWeight: TextStyleUtils.regual);
    }
  }

  List<Widget> _buildAnimateCollectWidget(
      MatchStatus matchStatus, MatchListModel model) {
    if (widget.isCollectCell || matchStatus != MatchStatus.finished) {
      return [
        _animateWidget(model),
        const SizedBox(width: 10),
        const SizedBox(width: 1, height: 26)
            .colored(Colors.black.withOpacity(0.1)),
        const SizedBox(width: 10),
        InkWell(
          onTap: _prepareMatchOperate,
          child: model.focus
              ? const JhAssetImage("match/iconMatchCollectS", width: 20)
              : const JhAssetImage("match/iconMatchCollect", width: 20),
        ),
      ];
    } else {
      return [
        _animateWidget(model),
      ];
    }
  }

  _animateWidget(MatchListModel model) {
    if (ConfigManager.instance.videoOk &&
        (model.hasVid > 0 && model.hasLive > 0)) {
      return const JhAssetImage("match/iconMatchVideo", width: 24);
    } else if (ConfigManager.instance.animateOk && model.lmtMode > 0) {
      return const JhAssetImage("match/iconMatchAnimate", width: 24);
    } else {
      return const SizedBox(width: 24);
    }
  }
}
