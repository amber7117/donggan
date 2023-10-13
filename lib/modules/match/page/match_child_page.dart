import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/modules/match/widget/match_child_cell_widget.dart';
import 'package:wzty/modules/match/widget/match_head_date_widget.dart';
import 'package:wzty/utils/toast_utils.dart';
import 'package:wzty/utils/wz_date_utils.dart';

class MatchChildPage extends StatefulWidget {
  final SportType sportType;
  final MatchStatus matchStatus;

  const MatchChildPage(
      {super.key, required this.sportType, required this.matchStatus});

  @override
  State<StatefulWidget> createState() {
    return _MatchChildPageState();
  }
}

class _MatchChildPageState extends KeepAliveLifeWidgetState<MatchChildPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<MatchListModel> _dataArr = [];

  int _selectIdx = 0;
  final List<String> _titleStrArr = [];
  final List<String> _dateStrArr = [];

  final EasyRefreshController _refreshCtrl = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();

    _createData();
    _requestData(loading: true);
  }

  _createData() {
    DateTime nowDate = DateTime.now();
    String nowDateStr = DateFormat('yyyy-MM-dd').format(nowDate);

    if (widget.matchStatus == MatchStatus.finished ||
        widget.matchStatus == MatchStatus.uncoming) {
      if (widget.matchStatus == MatchStatus.uncoming) {
        _titleStrArr.add('今天');
        _dateStrArr.add(nowDateStr);
      }

      DateTime tmpDate;
      String tmpDateStr;
      String tmpWeekStr;

      for (int idx = 1; idx < 5; idx++) {
        if (widget.matchStatus == MatchStatus.uncoming) {
          tmpDate = nowDate.add(Duration(days: idx));
        } else {
          tmpDate = nowDate.add(Duration(days: idx - 5));
        }

        tmpDateStr = DateFormat('yyyy-MM-dd').format(tmpDate);

        _dateStrArr.add(tmpDateStr);

        String weekDesc = WZDateUtils.getWeekDay(tmpDate);
        tmpWeekStr = '${tmpDateStr.substring(5)}\n$weekDesc';
        _titleStrArr.add(tmpWeekStr);
      }

      _selectIdx = 0;

      if (widget.matchStatus == MatchStatus.finished) {
        _titleStrArr.add('今天');
        _dateStrArr.add(nowDateStr);

        _selectIdx = _titleStrArr.length - 1;
      }
    } else {
      _dateStrArr.add(nowDateStr);
      _selectIdx = 0;
    }
  }

  _requestData({bool loading = false, String calendarDate = ''}) async {
    // if (!domainOk()) {
    //   return;
    // }

    String userId = await UserManager.instance.obtainUseridOrDeviceid();
    Map<String, dynamic> params = {
      'isComplete': 1,
      'isFormated': 0,
      'isAll': 0,
      'userId': userId,
      'sportType': widget.sportType.value,
    };

    if (calendarDate.isNotEmpty) {
      params['date'] = calendarDate;
    } else if (_dateStrArr.isNotEmpty) {
      params['date'] = _dateStrArr[_selectIdx];
    }

    // if (widget.matchStatus != MatchStatus.going) {
    params['status'] = matchStatusToServerValue(widget.matchStatus);
    // }

    // if (leagueIdArr.isNotEmpty) {
    //   params['leagueIds'] = leagueIdArr;
    //   params['filterType'] = conditionType.index;
    // } else if (conditionType != ConditionType.unknown) {
    //   params['filterType'] = conditionType.index;
    // }

    MatchStatus matchStatus = widget.matchStatus;

    if (loading) ToastUtils.showLoading();

    MatchService.requestMatchList(params, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        if (result != null) {
          var modelArrTmp = <MatchListModel>[];
          if (matchStatus == MatchStatus.uncoming) {
            modelArrTmp = result.uncoming?.matches ?? [];
          } else if (matchStatus == MatchStatus.finished) {
            modelArrTmp = result.finished?.matches ?? [];
          } else if (matchStatus == MatchStatus.going) {
            modelArrTmp = result.going?.matches ?? [];
          }

          // modelArr = processListCollectStatus(data: modelArrTmp);
          _dataArr = modelArrTmp;
        }
        if (_dataArr.isNotEmpty) {
          _layoutState = LoadStatusType.success;
        } else {
          _layoutState = LoadStatusType.empty;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }

      _refreshCtrl.finishRefresh();

      setState(() {});
    });
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChildWidget());
  }

  _buildChildWidget() {
    if (widget.matchStatus == MatchStatus.uncoming ||
        widget.matchStatus == MatchStatus.finished) {
      return Column(
        children: [
          MatchHeadDateWidget(dateArr: _titleStrArr, selectIdx: _selectIdx),
          Expanded(
              child: EasyRefresh(
                  controller: _refreshCtrl,
                  onRefresh: () async {
                    _requestData();
                  },
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 3),
                      itemCount: _dataArr.length,
                      itemExtent: matchChildCellHeight,
                      itemBuilder: (context, index) {
                        return MatchChildCellWidget(
                            sportType: widget.sportType,
                            model: _dataArr[index]);
                      })))
        ],
      );
    } else {
      return EasyRefresh(
          controller: _refreshCtrl,
          onRefresh: () async {
            _requestData();
          },
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 3),
              itemCount: _dataArr.length,
              itemExtent: matchChildCellHeight,
              itemBuilder: (context, index) {
                return MatchChildCellWidget(
                    sportType: widget.sportType, model: _dataArr[index]);
              }));
    }
  }
}
