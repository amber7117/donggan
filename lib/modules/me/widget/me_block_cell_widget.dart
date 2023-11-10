import 'package:flutter/material.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/common/widget/wz_block_button.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/anchor/manager/user_block_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeBlockCellWidget extends StatefulWidget {
  final UserBlockEntity model;

  const MeBlockCellWidget({super.key, required this.model});

  @override
  State<StatefulWidget> createState() {
    return _MeBlockCellWidgetState();
  }
}

class _MeBlockCellWidgetState extends State<MeBlockCellWidget> {
  Future<bool> _requestFollowUser() async {
    return true;
    // UserBlockEntity model = widget.model;

    // bool isFollow = !model.isAttention;

    // ToastUtils.showLoading();

    // HttpResultBean result =
    //     await MeService.requestUserFocus(model.userId, isFollow);

    // ToastUtils.hideLoading();
    // if (!result.isSuccess()) {
    //   ToastUtils.showError(result.msg ?? result.data);
    // }

    // return result.isSuccess();
  }

  @override
  Widget build(BuildContext context) {
    UserBlockEntity model = widget.model;
    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleImgPlaceWidget(
              imgUrl: model.headImgUrl,
              width: 36,
              placeholder: "common/iconTouxiang"),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.nickName,
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
          WZBlockBtn(
              followed: true,
              handleFollow: () async {
                return _requestFollowUser();
              }),
        ],
      ),
    );
  }
}
