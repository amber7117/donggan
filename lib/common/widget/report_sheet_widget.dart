import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';

const double reportSheetItemHeight = 56.0;

class ReportSheetWidget extends StatelessWidget {
  final List<String> dataArr;

  final WZAnyCallback<String> callback;

  const ReportSheetWidget(
      {super.key, required this.dataArr, required this.callback});

  @override
  Widget build(BuildContext context) {
    double height = reportSheetItemHeight * (dataArr.length + 1) + 10;

    return Container(
      width: double.infinity,
      height: height + ScreenUtil().bottomBarHeight,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataArr.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String title = dataArr[index];
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    callback(title);
                  },
                  child: Container(
                    height: reportSheetItemHeight - 0.5,
                    alignment: Alignment.center,
                    child: Text(title,
                        style: const TextStyle(
                            color: ColorUtils.black34,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                    color: Color.fromRGBO(236, 236, 236, 1),
                    indent: 0,
                    height: 0.5);
              }),
          const SizedBox(width: double.infinity, height: 10)
              .colored(ColorUtils.gray248),
          Container(
              width: double.infinity,
              height: reportSheetItemHeight,
              alignment: Alignment.center,
              child: const Text("取消",
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 14,
                      fontWeight: FontWeight.normal)))
        ],
      ),
    );
  }
}
