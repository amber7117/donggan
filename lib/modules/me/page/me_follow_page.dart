import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/common/widget/wz_follow_button.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/me/entity/user_info_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
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
      setState(() {
        
      });
    });
  }

  Future<bool> _requestFollowUser(UserInfoEntity model) async {
    bool isFollow = !model.isAttention;

    ToastUtils.showLoading();

    HttpResultBean result = await MeService.requestUserFocus(model.userId, isFollow);

    ToastUtils.hideLoading();
    if (!result.isSuccess()) {
      ToastUtils.showError(result.data ?? result.msg);
    }

    return result.isSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, titleText: "我的关注"),
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
                  return _buildCellWidget(index);
                })));
  }

  _buildCellWidget(int idx) {
    UserInfoEntity model = _dataArr[idx];
    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
              child: SizedBox(
                  width: 36,
                  height: 36,
                  child: buildNetImage(model.headImgUrl,
                      width: 36.0,
                      height: 36.0,
                      fit: BoxFit.cover,
                      placeholder: "common/iconTouxiang"))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.nickname,
                  style: TextStyle(
                      color: const Color.fromRGBO(58, 58, 60, 1.0),
                      fontSize: 14.sp,
                      fontWeight: TextStyleUtils.medium),
                ),
                Text(
                  "粉丝数  ${model.fansCount}",
                  style: TextStyle(
                      color: ColorUtils.gray149,
                      fontSize: 11.sp,
                      fontWeight: TextStyleUtils.regual),
                ),
              ],
            ),
          )),
          WZFollowBtn(followed: true, handleFollow: () async {
            return _requestFollowUser(model);
          }),
        ],
      ),
    );
  }
}
