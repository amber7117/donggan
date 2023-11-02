import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/match_calendar_entity.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/modules/match/widget/match_cell_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class AnchorDetailCalendarPage extends StatefulWidget {
  final int anchorId;
  
  const AnchorDetailCalendarPage({super.key, required this.anchorId});

  @override
  State createState() => _AnchorDetailCalendarPageState();
}

class _AnchorDetailCalendarPageState
    extends KeepAliveWidgetState<AnchorDetailCalendarPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<MatchCalendarEntity> _dataArr = [];

  final EasyRefreshController _refreshCtrl = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();

    _requestData(loading: true);
  }

  _requestData({bool loading = false}) async {
    if (loading) ToastUtils.showLoading();

    MatchService.requestAnchorCalendarMatch(widget.anchorId, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        if (result.isNotEmpty) {
          _dataArr = result;
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
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChildWidget());
  }

  _buildChildWidget() {
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
              return MatchCellWidget(calendarEntity: _dataArr[index]);
            }));
  }
}
