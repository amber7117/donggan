import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchChildPage extends StatefulWidget {
  const MatchChildPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MatchChildPageState();
  }
}

class _MatchChildPageState extends BaseWidgetState {

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }
  
  @override
  Widget buildWidget(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemExtent: 99,
        itemBuilder: (context, index) {
          return _buildCellWidget(index);
        });
  }

  _buildCellWidget(int idx) {
    return Container(
      height: 99,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "赛事名称",
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 10.sp,
                    fontWeight: TextStyleUtils.medium),
              ),
              Text(
                "未",
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 10.sp,
                    fontWeight: TextStyleUtils.medium),
              ),
              Text(
                "02:30",
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 10.sp,
                    fontWeight: TextStyleUtils.medium),
              ),
            ],
          )
        ],
      ),
    );
  }
}
