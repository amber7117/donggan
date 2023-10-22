import 'package:flutter/material.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/me/entity/user_info_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/modules/me/widget/me_follow_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeFollowPage extends StatefulWidget {
  const MeFollowPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MeFollowPageState();
  }
}

class _MeFollowPageState extends State {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<UserInfoEntity> _dataArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();
    
    MeService.requestFollowList(FollowListType.anchor, (success, result) {
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
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(titleText: "我的关注"),
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            state: _layoutState,
            successWidget: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _dataArr.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                      height: 0.5, color: ColorUtils.gray248, indent: 12);
                },
                itemBuilder: (context, index) {
                  return MeFollowCellWidget(model: _dataArr[index]);
                })));
  }
}
