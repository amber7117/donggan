import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/banner/entity/banner_entity.dart';
import 'package:wzty/utils/jh_image_utils.dart';

const liveBannerCellHeight = 162.0;

class AnchorBannerWidget extends StatefulWidget {
  final BannerModel model;

  const AnchorBannerWidget({super.key, required this.model});

  @override
  State createState() => _AnchorBannerWidgetState();
}

class _AnchorBannerWidgetState extends State<AnchorBannerWidget> {
  @override
  Widget build(BuildContext context) {
    BannerModel model = widget.model;
    return buildNetImage(model.img,
        width: ScreenUtil().screenWidth,
        height: liveBannerCellHeight,
        placeholder: "common/imgZhiboMoren", fit: BoxFit.fill);
  }
}
