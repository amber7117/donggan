import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_video_entity.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/detail/anchor_detail_playback_cell_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class AnchorDetailPlaybackPage extends StatefulWidget {
  final int anchorId;
  final String nickName;

  const AnchorDetailPlaybackPage(
      {super.key, required this.anchorId, required this.nickName});

  @override
  State createState() => _AnchorDetailCalendarPageState();
}

class _AnchorDetailCalendarPageState
    extends KeepAliveWidgetState<AnchorDetailPlaybackPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<AnchorVideoModel> _dataArr = [];

  final EasyRefreshController _refreshCtrl = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _page = 1;

  @override
  void initState() {
    super.initState();

    _requestData(loading: true);
  }

  _requestData({bool loading = false}) async {
    if (loading) ToastUtils.showLoading();

    AnchorService.requestPlaybackList(widget.anchorId, _page,
        (success, result) {
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
            itemExtent: playbackCellHeight,
            itemBuilder: (context, index) {
              return AnchorDetailPlaybackCellWidget(
                  model: _dataArr[index], nickName: widget.nickName);
            }));
  }
}
