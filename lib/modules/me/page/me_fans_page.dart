import 'package:flutter/material.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/me/entity/user_info_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeFansPage extends StatefulWidget {
  const MeFansPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MeFansPageState();
  }
}

class _MeFansPageState extends State {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<UserInfoEntity> _dataArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    MeService.requestFansList((success, result) {
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
        appBar: buildAppBar(titleText: "我的粉丝"),
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            state: _layoutState,
            successWidget: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _dataArr.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                      height: 0.5,
                      color: ColorUtils.gray248,
                      indent: 12,
                      thickness: 0.5);
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
        ],
      ),
    );
  }
}
