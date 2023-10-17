import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/common/widget/wz_follow_white_button.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/anchor/entity/live_detail_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class AnchorDetailUserInfoWidget extends StatefulWidget {
  final LiveDetailModel model;

  const AnchorDetailUserInfoWidget({super.key, required this.model});

  @override
  State createState() => _AnchorDetailUserInfoWidgetState();
}

class _AnchorDetailUserInfoWidgetState
    extends State<AnchorDetailUserInfoWidget> {
  Future<bool> _requestFollowUser() async {
    LiveDetailModel model = widget.model;

    bool isFollow = !model.fans.isTrue();

    ToastUtils.showLoading();

    HttpResultBean result =
        await MeService.requestUserFocus(model.userId.toString(), isFollow);

    ToastUtils.hideLoading();
    if (!result.isSuccess()) {
      ToastUtils.showError(result.msg ?? result.data);
    }

    return result.isSuccess();
  }

  @override
  Widget build(BuildContext context) {
    LiveDetailModel model = widget.model;

    return Container(
      width: 190,
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(217, 52, 52, 1.0),
            Color.fromRGBO(233, 78, 78, 1.0)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 2.0),
          CircleImgPlaceWidget(
              imgUrl: model.headImageUrl,
              width: 36.0,
              placeholder: "common/iconTouxiang"),
          const SizedBox(width: 6.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.nickname,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: TextStyleUtils.medium)),
                Text("${model.fans}粉丝",
                    style: TextStyle(
                        color: const Color.fromRGBO(251, 192, 192, 1.0),
                        fontSize: 10.sp,
                        fontWeight: TextStyleUtils.regual)),
              ],
            ),
          ),
          WZFollowWhiteBtn(
              followed: model.fansType.isTrue(),
              handleFollow: () async {
                return _requestFollowUser();
              }),
          const SizedBox(width: 12.0),
        ],
      ),
    );
  }
}
