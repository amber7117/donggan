import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/page/match_detail_bottom_page.dart';
import 'package:wzty/modules/match/provider/match_detail_data_provider.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_video_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_web_widget.dart';
import 'package:wzty/modules/match/widget/detail/match_detail_head_widget.dart';
import 'package:wzty/utils/toast_utils.dart';
import 'package:wzty/utils/wz_string_utils.dart';

class MatchDetailPage extends StatefulWidget {
  final int matchId;

  const MatchDetailPage({super.key, required this.matchId});

  @override
  State createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends KeepAliveLifeWidgetState<MatchDetailPage> {
  final MatchDetailDataProvider _dataProvider = MatchDetailDataProvider();

  LoadStatusType _layoutState = LoadStatusType.loading;
  MatchDetailModel? _model;

  final String playerId = WZStringUtils.generateRandomString(8);

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  @override
  void onPageResume() {
    super.onPageResume();

    if (_model != null) {
      eventBusManager.emit(PlayerStatusEvent(playerId: playerId, pause: false));
    }
  }

  @override
  void onPagePaused() {
    super.onPagePaused();

    if (_model != null) {
      eventBusManager.emit(PlayerStatusEvent(playerId: playerId, pause: true));
    }
  }

  _requestData() {
    ToastUtils.showLoading();

    MatchDetailService.requestMatchDetail(widget.matchId, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result != null) {
          _model = result;

          _layoutState = LoadStatusType.success;
        } else {
          _layoutState = LoadStatusType.empty;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }
      setState(() {});
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LoadStateWidget(
            state: _layoutState, successWidget: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }

    MatchDetailModel model = _model!;

    return ChangeNotifierProvider<MatchDetailDataProvider>(
        create: (context2) => _dataProvider,
        child: Column(
          children: [
            Consumer<MatchDetailDataProvider>(
                builder: (context, provider, child) {
              if (provider.showAnimate) {
                return MatchDetailHeadWebWidget(
                    height: videoHeight(), urlStr: provider.animateUrl);
              } else if (provider.showVideo) {
                String urlStr = model.obtainFirstVideoUrl();
                if (urlStr.isEmpty) {
                  urlStr = model.obtainSecondVideoUrl();
                }
                return MatchDetailHeadVideoWidget(
                    height: videoHeight(), urlStr: urlStr, playerId: playerId);
              } else {
                return MatchDetailHeadWidget(
                    height: videoHeight(), model: model);
              }
            }),
            Expanded(
              child:
                  MatchDetailBottomPage(matchId: _model!.matchId, model: model),
            ),
          ],
        ));
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }
}
