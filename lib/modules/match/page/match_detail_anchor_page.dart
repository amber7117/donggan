import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/live_list_entity.dart';
import 'package:wzty/modules/match/entity/match_anchor_entity.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/modules/match/widget/anchor/match_anchor_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailAnchorPage extends StatefulWidget {
  final int matchId;

  const MatchDetailAnchorPage({super.key, required this.matchId});

  @override
  State createState() => _MatchDetailAnchorPageState();
}

class _MatchDetailAnchorPageState extends KeepAliveWidgetState<MatchDetailAnchorPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  MatchAnchorModel? _model;
  final List<MatchAnchorType> _dataArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    MatchDetailService.requestMatchAnchor(widget.matchId, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result != null) {
          _model = result;

          _dataArr.clear();

          if (_model!.matchList.isNotEmpty) {
            _dataArr.add(MatchAnchorType.living);
          }
          if (_model!.otherMatchList.isNotEmpty) {
            _dataArr.add(MatchAnchorType.more);
          }

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
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
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
        List<LiveListModel> modelArr = _model!.matchList;
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
                    style: TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 14.sp,
                        fontWeight: TextStyleUtils.semibold))),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: liveCellRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 9,
              ),
              itemCount: modelArr.length,
              itemBuilder: (BuildContext context, int index) {
                return MatchAnchorCellWidget(model: modelArr[index]);
              },
            ),
          ],
        );
      },
    );
  }
}
