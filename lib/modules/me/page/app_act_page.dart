import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/banner/entity/banner_entity.dart';
import 'package:wzty/modules/banner/service/banner_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

const actBannerHeight = 160.0;

class AppActPage extends StatefulWidget {
  const AppActPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppActPageState();
  }
}

class _AppActPageState extends State {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<BannerModel> _dataArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    BannerService.requestBanner(BannerReqType.act, (success, result) {
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
        appBar: buildAppBar(titleText: "活动广场"),
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            state: _layoutState, successWidget: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_layoutState != LoadStatusType.success) {
      return const SizedBox();
    }
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _dataArr.length,
        separatorBuilder: (context, index) {
          return const Divider(
              height: 0.5, color: ColorUtils.gray248, indent: 12);
        },
        itemBuilder: (context, index) {
          return _buildCellWidget(index);
        });
  }

  _buildCellWidget(int idx) {
    BannerModel model = _dataArr[idx];
    return InkWell(
      onTap: () {
        model.jump(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: buildNetImage(model.img,
                width: ScreenUtil().screenWidth - 24,
                height: actBannerHeight,
                placeholder: "common/imgZhiboMoren")),
      ),
    );
  }
}
