import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/lib/load_empty_widget.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/match/entity/match_detail_entity.dart';
import 'package:wzty/modules/match/service/match_detail_service.dart';
import 'package:wzty/modules/match/widget/match_detail_head_widget.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailPage extends StatefulWidget {
  final int matchId;

  const MatchDetailPage({super.key, required this.matchId});

  @override
  State createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends State<MatchDetailPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  MatchDetailModel? _model;

  @override
  void initState() {
    super.initState();

    _requestData();
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
  Widget build(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }
    return Column(
      children: [
        MatchDetailHeadWidget(model: _model!),
      ],
    );
  }
}
