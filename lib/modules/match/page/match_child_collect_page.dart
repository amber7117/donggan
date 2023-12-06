import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';
import 'package:wzty/modules/match/manager/match_collect_manager.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/modules/match/widget/match_cell_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchChildCollectPage extends StatefulWidget {
  final SportType sportType;
  final bool redDot;
  const MatchChildCollectPage(
      {super.key, required this.sportType, this.redDot = true});

  @override
  State<StatefulWidget> createState() {
    return _MatchChildCollectPageState();
  }
}

class _MatchChildCollectPageState
    extends KeepAliveLifeWidgetState<MatchChildCollectPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<MatchListModel> _dataArr = [];

  final EasyRefreshController _refreshCtrl = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  late StreamSubscription _animateSub;

  @override
  void initState() {
    super.initState();

    List<MatchListModel> result =
        MatchCollectManager.instance.obtainCollectData(widget.sportType);
    _handleResultData(result);

    _animateSub = eventBusManager.on<AnimateStateEvent>((event) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    eventBusManager.off(_animateSub);
  }

  _handleResultData(List<MatchListModel> result) {
    if (result.isNotEmpty) {
      _dataArr = result;
      _layoutState = LoadStatusType.success;
    } else {
      _layoutState = LoadStatusType.empty;
    }
  }

  _requestData({bool loading = true}) async {
    if (loading) ToastUtils.showLoading();

    MatchService.requestMatchListAttr(widget.sportType, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        _handleResultData(result);
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
        state: _layoutState,
        successWidget: EasyRefresh(
            controller: _refreshCtrl,
            onRefresh: () async {
              _requestData(loading: false);
            },
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 3),
                itemCount: _dataArr.length,
                itemExtent: matchChildCellHeight,
                itemBuilder: (context, index) {
                  return MatchCellWidget(
                    sportType: widget.sportType,
                    listModel: _dataArr[index],
                    isCollectCell: true,
                    redDot: widget.redDot,
                  );
                })));
  }
}
