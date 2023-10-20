import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/widget/wz_sure_size_button.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum MatchFilterBottomEvent { selectAll, selectOther, sure }

class MatchFilterBottomWidget extends StatefulWidget {
  final WZAnyCallback<MatchFilterBottomEvent> callback;

  const MatchFilterBottomWidget({super.key, required this.callback});

  @override
  State createState() => MatchFilterBottomWidgetState();
}

class MatchFilterBottomWidgetState extends State<MatchFilterBottomWidget> {


  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(180, 180, 180, 0.2), // 阴影颜色
              spreadRadius: 0, // 阴影扩散程度
              blurRadius: 4, // 阴影模糊程度
              offset: Offset(0, -4), // 阴影偏移量
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              widget.callback(MatchFilterBottomEvent.selectAll);
            },
            child: Container(
              width: 56,
              height: 32,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(250, 250, 250, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Text("全选",
                  style: TextStyle(
                      color: const Color.fromRGBO(102, 102, 102, 1.0),
                      fontSize: 12.sp,
                      fontWeight: TextStyleUtils.medium)),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              widget.callback(MatchFilterBottomEvent.selectOther);
            },
            child: Container(
              width: 56,
              height: 32,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(250, 250, 250, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Text("反选",
                  style: TextStyle(
                      color: const Color.fromRGBO(102, 102, 102, 1.0),
                      fontSize: 12.sp,
                      fontWeight: TextStyleUtils.medium)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text("隐藏了0场",
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 14.sp,
                    fontWeight: TextStyleUtils.regual)),
          ),
          WZSureSizeButton(
              title: "确定",
              width: 80,
              height: 32,
              handleTap: () {
                widget.callback(MatchFilterBottomEvent.sure);
              }),
        ],
      ),
    );
  }
}
