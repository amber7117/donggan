import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_manager.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/anchor_banner_widget.dart';
import 'package:wzty/modules/anchor/widget/anchor_match_cell_widget.dart';
import 'package:wzty/modules/banner/entity/banner_entity.dart';
import 'package:wzty/modules/banner/service/banner_service.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';
import 'package:wzty/modules/anchor/widget/anchor_cell_widget.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class AnchorChildHotPage extends StatefulWidget {
  const AnchorChildHotPage({super.key});

  @override
  State createState() => _AnchorChildHotPageState();
}

class _AnchorChildHotPageState
    extends KeepAliveWidgetState<AnchorChildHotPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<BannerModel> _bannerArr = [];
  List<MatchListModel> _matchArr = [];
  List<AnchorListModel> _anchorArr = [];

  // final EasyRefreshController _refreshCtrl = EasyRefreshController(
  //   controlFinishRefresh: true,
  //   controlFinishLoad: true,
  // );
  int _page = 1;

  late StreamSubscription _blockSub;
  late StreamSubscription _activeUserSub;

  @override
  void initState() {
    super.initState();

    _requestData();

    _blockSub = eventBusManager.on<BlockAnchorEvent>((event) async {
      if (mounted) {
        _anchorArr = await _removeBlockData(_anchorArr);
        setState(() {});
      }
    });
    _activeUserSub = eventBusManager.on<ActiveUserEvent>((event) async {
      if (mounted) {
        notifyActiveUser();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    eventBusManager.off(_blockSub);
    eventBusManager.off(_activeUserSub);
  }

  _requestData({bool loading = true}) {
    if (loading) ToastUtils.showLoading();

    Future banner =
        BannerService.requestBanner(BannerReqType.anchor, (success, result) {
      _bannerArr = result;
    });

    Future anchor = AnchorService.requestHotList(_page, (success, result) {
      var resultTmp = _handleActiveUserData(result);

      _anchorArr = resultTmp;
    });

    Future.wait([banner, anchor]).then((value) {
      ToastUtils.hideLoading();

      if (_anchorArr.isEmpty && _bannerArr.isEmpty) {
        _layoutState = LoadStatusType.empty;
      } else {
        _layoutState = LoadStatusType.success;

        MatchService.requestHotMatchList((success, result) {
          if (result.isNotEmpty) {
            _matchArr = result;
            setState(() {});
          }
        });
      }
      setState(() {});
    });
  }

  _requestAnchorData() {
    AnchorService.requestHotList(_page, (success, result) {
      if (success) {
        var resultTmp = _handleActiveUserData(result);
        _anchorArr = resultTmp;

        if (resultTmp.isNotEmpty) {
          _layoutState = LoadStatusType.success;
        }

        setState(() {});
      }
    });
  }

  // ---------------------------------------------

  Future<List<AnchorListModel>> _removeBlockData(
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
    // if (!ConfigManager.instance.activeUser) {
    //   return;
    // }

    _anchorArr.clear();

    _requestAnchorData();
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bannerArr.isEmpty
            ? const SizedBox()
            : AnchorBannerWidget(bannerArr: _bannerArr),
        _matchArr.isEmpty
            ? const SizedBox()
            : Container(
                width: double.infinity,
                height: liveMatchCellHeight + 24.0,
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _matchArr.length,
                    itemExtent: liveMatchCellWidth,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return AnchorMatchCellWidget(model: _matchArr[index]);
                    }),
              ),
        const Row(
          children: [
            Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 5),
                child: JhAssetImage("anchor/iconFire2", width: 16)),
            Text("热门直播",
                style: TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 14,
                    fontWeight: TextStyleUtils.semibold)),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
        ),
      ],
    );
  }
}
