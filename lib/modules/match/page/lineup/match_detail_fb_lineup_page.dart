import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_model.dart';
import 'package:wzty/modules/match/service/match_detail_lineup_service.dart';
import 'package:wzty/modules/match/widget/lineup/match_lineup_fb_cell_widget.dart';
import 'package:wzty/modules/match/widget/lineup/match_lineup_fb_head_widget.dart';
import 'package:wzty/modules/match/widget/lineup/match_lineup_segment_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailFBLineupPage extends StatefulWidget {
  final int matchId;

  final MatchDetailModel detailModel;

  const MatchDetailFBLineupPage(
      {super.key, required this.matchId, required this.detailModel});

  @override
  State createState() => _MatchDetailFBLineupPageState();
}

class _MatchDetailFBLineupPageState
    extends KeepAliveWidgetState<MatchDetailFBLineupPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;

  MatchLineupFBModel? model;
  final List<String> titleArr = ["主队名单", "客队名单"];
  int selectIdx = 0;

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    MatchDetailLineupService.requestFBLineup(widget.matchId, (success, result) {
      ToastUtils.hideLoading();
      if (result != null &&
          (result.hostTeamMatchLineupList.isNotEmpty ||
              result.guestTeamMatchLineupList.isNotEmpty)) {
        model = result;
        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.empty;
      }
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

    MatchStatus matchStatus =
        matchStatusFromServerValue(widget.detailModel.matchStatus);
    bool uncoming = matchStatus == MatchStatus.uncoming;

    List<MatchLineupFBPlayerModel> playerList1 = [];
    List<MatchLineupFBPlayerModel> playerList2 = [];
    bool isHost = true;
    if (selectIdx == 0) {
      playerList1 = model!.hostMainPlayerList!;
      playerList2 = model!.hostSubPlayerList!;
    } else {
      playerList1 = model!.guestMainPlayerList!;
      playerList2 = model!.guestSubPlayerList!;
      isHost = false;
    }
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: MatchLineupSegmentWidget(
                titleArr: titleArr,
                selectIdx: selectIdx,
                callback: (data) {
                  selectIdx = data;
                  setState(() {});
                })),
        SliverToBoxAdapter(
            child: MatchLineupFbHeadWidget(
                model: model!,
                isHost: isHost,
                uncoming: uncoming,
                detailModel: widget.detailModel)),
        SliverList.builder(
            itemCount: playerList1.length,
            itemBuilder: (context, index) {
              return MatchLineupFbCellWidget(
                  model: playerList1[index], isHost: isHost);
            }),
        SliverToBoxAdapter(
            child: Container(
          width: double.infinity,
          height: 36,
          alignment: Alignment.center,
          color: ColorUtils.gray248,
          child: const Text(
            "替补名单",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
        )),
        SliverList.builder(
            itemCount: playerList2.length,
            itemBuilder: (context, index) {
              return MatchLineupFbCellWidget(
                  model: playerList2[index], isHost: isHost);
            }),
      ],
    );
  }
}
