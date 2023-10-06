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
        itemExtent: 105,
        itemBuilder: (context, index) {
          return _buildCellWidget(index);
        });
  }

  _buildCellWidget(int idx) {
    return Container(
      height: 105,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  "赛事名称",
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 10.sp,
                      fontWeight: TextStyleUtils.medium),
                ),
              ),
              Text(
                "未",
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 10.sp,
                    fontWeight: TextStyleUtils.medium),
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  "02:30",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 10.sp,
                      fontWeight: TextStyleUtils.medium),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(253, 192, 200, 1.0),
                  Color.fromRGBO(200, 221, 253, 1.0),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "皇家马德里",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 12.sp,
                          fontWeight: TextStyleUtils.semibold),
                    ),
                    Text(
                      "巴黎圣日尔曼",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 12.sp,
                          fontWeight: TextStyleUtils.semibold),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "-",
                    style: TextStyle(
                        color: ColorUtils.gray153,
                        fontSize: 10.sp,
                        fontWeight: TextStyleUtils.medium),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: ColorUtils.gray153,
                        fontSize: 10.sp,
                        fontWeight: TextStyleUtils.medium),
                  ),
                ],
              ),
              SizedBox(
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    JhAssetImage("match/iconMatchVideo", width: 24.w),
                    SizedBox(width: 10.w),
                    Container(
                        width: 1,
                        height: 26,
                        color: Colors.black.withOpacity(0.1)),
                    SizedBox(width: 10.w),
                    JhAssetImage("match/iconMatchCollect", width: 20.w),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
