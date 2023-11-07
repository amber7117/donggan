import 'package:flutter/material.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/common/widget/wz_follow_button.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

const double searchResultCellHeight = 64.0;

class SearchResultCellWidget extends StatefulWidget {
  final AnchorListModel anchor;

  const SearchResultCellWidget({super.key, required this.anchor});

  @override
  State createState() => _SearchResultCellWidgetState();
}

class _SearchResultCellWidgetState extends State<SearchResultCellWidget> {
  Future<bool> _requestFollowUser() async {
    if (!UserManager.instance.isLogin()) {
      Routes.goLoginPage(context);
      return false;
    }
    
    AnchorListModel anchor = widget.anchor;

    bool isFollow = !anchor.isAttention.isTrue();

    ToastUtils.showLoading();

    HttpResultBean result =
        await MeService.requestUserFocus(anchor.userId.toString(), isFollow);

    ToastUtils.hideLoading();
    if (!result.isSuccess()) {
      ToastUtils.showError(result.msg ?? result.data);
    }

    return result.isSuccess();
  }

  @override
  Widget build(BuildContext context) {
    AnchorListModel anchor = widget.anchor;
    String fansDesc = AppBusinessUtils.obtainFansDesc(anchor.fans);

    return InkWell(
      onTap: () {
        Routes.push(context, Routes.anchorDetail, arguments: anchor.anchorId);
      },
      child: SizedBox(
        height: searchResultCellHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(width: 12),
            CircleImgPlaceWidget(
                imgUrl: anchor.headImageUrl,
                width: 44,
                placeholder: "common/iconTouxiang"),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(anchor.nickName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 14,
                          fontWeight: TextStyleUtils.regual)),
                  Text("粉丝$fansDesc",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: ColorUtils.gray149,
                          fontSize: 12,
                          fontWeight: TextStyleUtils.regual))
                ],
              ),
            ),
            WZFollowBtn(
                followed: anchor.isAttention.isTrue(),
                handleFollow: _requestFollowUser)
          ],
        ),
      ),
    );
  }
}
