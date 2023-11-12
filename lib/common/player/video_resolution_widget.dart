import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/player/wz_player_manager.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class VideoResolutionWidget extends StatelessWidget {
  final Rect playRect;
  final bool fullScreen;
  final WZAnyCallback callback;

  const VideoResolutionWidget(
      {super.key, required this.fullScreen, required this.callback, required this.playRect});

  @override
  Widget build(BuildContext context) {
    String resolution = WZPlayerManager.instance.resolution;
    List<String> titleArr = WZPlayerManager.instance.titleArr;

    return SizedBox(
      width: playRect.width,
      height: playRect.height,
      child: Container(
          width: ScreenUtil().scaleWidth * 0.5,
          height: playRect.height,
          color: Colors.yellow,
          // color: Colors.black.withOpacity(0.6),
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 270,
            height: 66,
            child: GridView.builder(
                padding: const EdgeInsets.only(top: 10, left: 12, bottom: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: titleArr.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  childAspectRatio: 60 / 28,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      callback(index);
                    },
                    child: _buildCellWidget(titleArr[index]),
                  );
                }),
          )),
    );
  }

  _buildCellWidget(String title) {
    return Container(
        child: Text(title,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 16,
                fontWeight: TextStyleUtils.regual)));
  }
}
