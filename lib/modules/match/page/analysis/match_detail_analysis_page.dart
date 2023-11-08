import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_analysis_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/service/match_detail_analysis_service.dart';
import 'package:wzty/modules/match/widget/analysis/match_analysis_history_cell_widget.dart';
import 'package:wzty/modules/match/widget/analysis/match_analysis_history_foot_widget.dart';
import 'package:wzty/modules/match/widget/analysis/match_analysis_history_head_widget.dart';
import 'package:wzty/modules/match/widget/analysis/match_analysis_rank_cell_widget.dart';
import 'package:wzty/modules/match/widget/analysis/match_analysis_rank_head_widget.dart';
import 'package:wzty/modules/match/widget/analysis/match_analysis_schedule_cell_widget.dart';
import 'package:wzty/modules/match/widget/analysis/match_analysis_schedule_head_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailAnalysisPage extends StatefulWidget {
  final int matchId;

  final MatchDetailModel detailModel;

  const MatchDetailAnalysisPage(
      {super.key, required this.matchId, required this.detailModel});

  @override
  State createState() => _MatchDetailAnalysisPageState();
}

class _MatchDetailAnalysisPageState
    extends KeepAliveWidgetState<MatchDetailAnalysisPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;

  List<MatchAnalysisRankTeamModel> rankArr = [];
  MatchAnalysisHistoryModel? historyModel;
  MatchAnalysisHistoryModel? recent1Model;
  MatchAnalysisHistoryModel? recent2Model;
  List<MatchAnalysisMatchModel> future1Arr = [];
  List<MatchAnalysisMatchModel> future2Arr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    int matchId = widget.matchId;
    MatchDetailModel model = widget.detailModel;

    ToastUtils.showLoading();

    Future rank = MatchDetailAnalysisService.requestRankData(
        SportType.football, widget.matchId, (success, result) {
      rankArr = result;
    });

    Future history = MatchDetailAnalysisService.requestHistoryData(
        matchId, model.hostTeamId, model.guestTeamId, true, (success, result) {
      historyModel = result;
    });

    Future recent1 = MatchDetailAnalysisService.requestRecentData(
        SportType.football, matchId, model.hostTeamId, true, (success, result) {
      recent1Model = result;
    });
    Future recent2 = MatchDetailAnalysisService.requestRecentData(
        SportType.football, matchId, model.guestTeamId, true,
        (success, result) {
      recent2Model = result;
    });

    Future future1 = MatchDetailAnalysisService.requestFutureData(
        matchId, model.hostTeamId, (success, result) {
      future1Arr = result;
    });
    Future future2 = MatchDetailAnalysisService.requestFutureData(
        matchId, model.guestTeamId, (success, result) {
      future2Arr = result;
    });

    Future.wait([rank, history, recent1, recent2, future1, future2])
        .then((value) {
      ToastUtils.hideLoading();

      _layoutState = LoadStatusType.success;

      setState(() {});
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    if (_layoutState != LoadStatusType.success) {
      return const SizedBox();
    }

    SportType sportType = SportType.football;
    if (widget.detailModel.sportId == SportType.basketball.value) {
      sportType = SportType.basketball;
    }

    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildRank(sportType);
          } else if (index == 1) {
            return _buildHistory(sportType);
          } else if (index == 2) {
            return _buildRecent1(sportType);
          } else if (index == 3) {
            return _buildRecent2(sportType);
          } else if (index == 4) {
            return _buildFuture1();
          } else if (index == 5) {
            return _buildFuture2();
          }
          return const SizedBox();
        });
  }

  _buildRank(SportType sportType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MatchAnalysisRankHeadWidget(
            key: const ValueKey(1), sportType: sportType),
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: rankArr.length,
            itemExtent: 40.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return MatchAnalysisRankCellWidget(
                  model: rankArr[index], sportType: sportType);
            })
      ],
    );
  }

  _buildHistory(SportType sportType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MatchAnalysisHistoryHeadWidget(
            key: const ValueKey(2),
            type: MatchAnalysisHistoryHeadType.history,
            sportType: sportType),
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: historyModel!.matches.length,
            itemExtent: 42.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return MatchAnalysisHistoryCellWidget(
                  model: historyModel!.matches[index],
                  sportType: sportType,
                  mainTeamName: widget.detailModel.hostTeamName);
            }),
        MatchAnalysisHistoryFootWidget(
          sportType: sportType,
          model: historyModel!,
          logo: widget.detailModel.hostTeamLogo,
          team: widget.detailModel.hostTeamName,
        )
      ],
    );
  }

  _buildRecent1(SportType sportType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MatchAnalysisHistoryHeadWidget(
            key: const ValueKey(3),
            type: MatchAnalysisHistoryHeadType.recent1,
            sportType: sportType),
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: recent1Model!.matches.length,
            itemExtent: 42.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return MatchAnalysisHistoryCellWidget(
                  model: recent1Model!.matches[index],
                  sportType: sportType,
                  mainTeamName: widget.detailModel.hostTeamName);
            })
      ],
    );
  }

  _buildRecent2(SportType sportType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MatchAnalysisHistoryHeadWidget(
            key: const ValueKey(4),
            type: MatchAnalysisHistoryHeadType.recent2,
            sportType: sportType),
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: recent2Model!.matches.length,
            itemExtent: 42.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return MatchAnalysisHistoryCellWidget(
                  model: recent2Model!.matches[index],
                  sportType: sportType,
                  mainTeamName: widget.detailModel.guestTeamName);
            })
      ],
    );
  }

  _buildFuture1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MatchAnalysisScheduleHeadWidget(
            key: ValueKey(5), type: MatchAnalysisScheduleHeadType.future1),
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: future1Arr.length,
            itemExtent: 42.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return MatchAnalysisScheduleCellWidget(
                  model: future1Arr[index],
                  mainTeamName: widget.detailModel.hostTeamName);
            })
      ],
    );
  }

  _buildFuture2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MatchAnalysisScheduleHeadWidget(
            key: ValueKey(6), type: MatchAnalysisScheduleHeadType.future2),
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: future2Arr.length,
            itemExtent: 42.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return MatchAnalysisScheduleCellWidget(
                  model: future2Arr[index],
                  mainTeamName: widget.detailModel.guestTeamName);
            })
      ],
    );
  }
}
