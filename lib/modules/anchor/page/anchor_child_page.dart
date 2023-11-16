import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_manager.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/anchor_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class AnchorChildPage extends StatefulWidget {
  final LiveSportType type;

  const AnchorChildPage({super.key, required this.type});

  @override
  State createState() => _AnchorChildPageState();
}

class _AnchorChildPageState extends KeepAliveWidgetState<AnchorChildPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;

  List<AnchorListModel> _anchorArr = [];

  final EasyRefreshController _refreshCtrl = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  late StreamSubscription _eventSub;

  @override
  void initState() {
    super.initState();

    _requestData();

    _eventSub = eventBusManager.on<BlockAnchorEvent>((event) async {
      if (mounted) {
        _anchorArr = await removeBlockData(_anchorArr);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    eventBusManager.off(_eventSub);
  }

  _requestData({bool loading = true}) async {
    if (loading) ToastUtils.showLoading();

    AnchorService.requestTypeList(widget.type, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result.isNotEmpty) {
          _anchorArr = result;

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

  // ---------------------------------------------

  Future<List<AnchorListModel>> removeBlockData(
      List<AnchorListModel> listArr) async {
    List<UserBlockEntity> blockAuthorArr =
        await UserBlockManger.instance.obtainBlockData();
    if (blockAuthorArr.isEmpty) {
      return listArr;
    }

    List<AnchorListModel> arrTmp = [];
    for (var model in listArr) {
      if (!UserBlockManger.instance.getBlockStatus(userId: model.anchorId)) {
        arrTmp.add(model);
      }
    }

    return arrTmp;
  }

  // ---------------------------------------------

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        errorRetry: _requestData,
        state: _layoutState,
        successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    if (_layoutState != LoadStatusType.success) {
      return const SizedBox();
    }
    return EasyRefresh(
        controller: _refreshCtrl,
        onRefresh: () async {
          _requestData(loading: false);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12, right: 5),
                      child: JhAssetImage("anchor/iconFire2", width: 16)),
                  Text("${widget.type.title}直播",
                      style: const TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 14,
                          fontWeight: TextStyleUtils.semibold)),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: anchorCellRatio,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 9,
                  ),
                  itemCount: _anchorArr.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnchorCellWidget(model: _anchorArr[index]);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
