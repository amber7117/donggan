import 'package:flutter/material.dart';
import 'package:wzty/common/widget/wz_follow_button.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/me/entity/user_info_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeFollowCellWidget extends StatefulWidget {
  final UserInfoEntity model;

  const MeFollowCellWidget({super.key, required this.model});

  @override
  State<StatefulWidget> createState() {
    return _MeFollowCellWidgetState();
  }
}

class _MeFollowCellWidgetState extends State<MeFollowCellWidget> {
  Future<bool> _requestFollowUser() async {
    UserInfoEntity model = widget.model;

    bool isFollow = !model.isAttention;

    ToastUtils.showLoading();

    HttpResultBean result =
        await MeService.requestUserFocus(model.userId, isFollow);

    ToastUtils.hideLoading();
    if (!result.isSuccess()) {
      ToastUtils.showError(result.msg ?? result.data);
    }

    return result.isSuccess();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoEntity model = widget.model;
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
                  style: const TextStyle(
                      color: Color.fromRGBO(58, 58, 60, 1.0),
                      fontSize: 14,
                      fontWeight: TextStyleUtils.medium),
                ),
                Text(
                  "粉丝数  ${model.fansCount}",
                  style: const TextStyle(
                      color: ColorUtils.gray149,
                      fontSize: 11,
                      fontWeight: TextStyleUtils.regual),
                ),
              ],
            ),
          )),
          WZFollowBtn(
              followed: true,
              handleFollow: () async {
                return _requestFollowUser();
              }),
        ],
      ),
    );
  }
}
