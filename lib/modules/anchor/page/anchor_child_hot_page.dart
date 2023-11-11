import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
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

  @override
  void initState() {
    super.initState();

    _requestData(loading: true);
  }

  _requestData({bool loading = false}) async {
    if (loading) ToastUtils.showLoading();

    Future banner =
        BannerService.requestBanner(BannerReqType.anchor, (success, result) {
      _bannerArr = result;
    });
    Future match = MatchService.requestHotMatchList((success, result) {
      _matchArr = result;
    });
    Future anchor = AnchorService.requestHotList(_page, (success, result) {
      _anchorArr = result;
    });

    Future.wait([banner, match, anchor]).then((value) {
      ToastUtils.hideLoading();

      if (_anchorArr.isNotEmpty) {
        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.failure;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bannerArr.isNotEmpty
            ? AnchorBannerWidget(bannerArr: _bannerArr)
            : const SizedBox(),
        Container(
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
