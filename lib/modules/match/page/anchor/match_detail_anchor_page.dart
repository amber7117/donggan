import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/match/entity/match_anchor_entity.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/modules/anchor/widget/anchor_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailAnchorPage extends StatefulWidget {
  final int matchId;

  const MatchDetailAnchorPage({super.key, required this.matchId});

  @override
  State createState() => _MatchDetailAnchorPageState();
}

class _MatchDetailAnchorPageState
    extends KeepAliveWidgetState<MatchDetailAnchorPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  MatchAnchorModel? _model;
  final List<MatchAnchorType> _dataArr = [];

  late StreamSubscription _activeUserSub;

  @override
  void initState() {
    super.initState();

    _requestData();

    _activeUserSub = eventBusManager.on<ActiveUserEvent>((event) async {
      if (mounted) {
        notifyActiveUser();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    eventBusManager.off(_activeUserSub);
  }

  _requestData() {
    ToastUtils.showLoading();

    MatchDetailService.requestMatchAnchor(widget.matchId, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result != null) {
          _model = result;

          _dataArr.clear();

          _model!.matchList = _handleActiveUserData(_model!.matchList);
          _model!.otherMatchList =
              _handleActiveUserData(_model!.otherMatchList);

          if (_model!.matchList.isNotEmpty) {
            _dataArr.add(MatchAnchorType.living);
          }
          if (_model!.otherMatchList.isNotEmpty) {
            _dataArr.add(MatchAnchorType.more);
          }
        }

        if (_dataArr.isEmpty) {
          _layoutState = LoadStatusType.empty;
        } else {
          _layoutState = LoadStatusType.success;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }
      setState(() {});
    });
  }

  List<AnchorListModel> _handleActiveUserData(List<AnchorListModel> list) {
    if (ConfigManager.instance.activeUser) {
      return list;
    }

    List<AnchorListModel> arr = [];
    for (var model in list) {
      if (model.isGreenLive.isTrue()) {
        arr.add(model);
      }
    }
    return arr;
  }

  void notifyActiveUser() {
    if (!ConfigManager.instance.activeUser) {
      return;
    }

    _requestData();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: _dataArr.length,
      itemBuilder: (BuildContext context, int index) {
        MatchAnchorType type = _dataArr[index];
        List<AnchorListModel> modelArr = _model!.matchList;
        String cellTitle = "本场直播";
        if (type == MatchAnchorType.more) {
          modelArr = _model!.otherMatchList;
          cellTitle = "热门直播";
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 12),
                child: Text(cellTitle,
                    style: const TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 14,
                        fontWeight: TextStyleUtils.semibold))),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: anchorCellRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 9,
              ),
              itemCount: modelArr.length,
              itemBuilder: (BuildContext context, int index) {
                return AnchorCellWidget(model: modelArr[index]);
              },
            ),
          ],
        );
      },
    );
  }
}
