import 'package:flutter/material.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_bb_model.dart';
import 'package:wzty/modules/match/service/match_detail_lineup_service.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailBBLineupPage extends StatefulWidget {
  final int matchId;

  final MatchDetailModel detailModel;

  const MatchDetailBBLineupPage(
      {super.key, required this.matchId, required this.detailModel});

  @override
  State createState() => _MatchDetailBBLineupPageState();
}

class _MatchDetailBBLineupPageState
    extends KeepAliveWidgetState<MatchDetailBBLineupPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;

  MatchLineupBBModel? model;

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    MatchDetailLineupService.requestBBLineup(
        widget.matchId, widget.detailModel.hostTeamName, (success, result) {
      if (result != null) {
        model = result;
        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.empty;
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container();
  }
}
