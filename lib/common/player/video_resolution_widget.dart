import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/player/player_data_manager.dart';
import 'package:wzty/utils/color_utils.dart';

class VideoResolutionWidget extends StatelessWidget {
  final Rect playRect;
  final bool fullScreen;
  final WZAnyCallback<String> callback;

  const VideoResolutionWidget(
      {super.key,
      required this.fullScreen,
      required this.callback,
      required this.playRect});

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return _buildFullscreenUI();
    } else {
      return _buildNormalUI();
    }
  }

  _buildNormalUI() {
    String resolution = PlayerDataManager.instance.resolution;
    List<String> titleArr = PlayerDataManager.instance.titleArr;

    return InkWell(
      onTap: () {
        callback("");
      },
      child: SizedBox(
        width: playRect.width,
        height: playRect.height,
        child: Container(
            width: playRect.width * 0.5,
            height: playRect.height,
            color: Colors.black.withOpacity(0.6),
            alignment: Alignment.center,
            child: SizedBox(
              width: 270,
              height: 66,
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: titleArr.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 60 / 28,
                  ),
                  itemBuilder: (context, index) {
                    String title = titleArr[index];
                    return _buildCellWidget(title, title == resolution);
                  }),
            )),
      ),
    );
  }

  _buildFullscreenUI() {
    String resolution = PlayerDataManager.instance.resolution;
    List<String> titleArr = PlayerDataManager.instance.titleArr;

    return InkWell(
      onTap: () {
        callback("");
      },
      child: Container(
        width: playRect.width,
        height: playRect.height,
        alignment: Alignment.centerRight,
        child: Container(
            width: playRect.width * 0.4,
            height: playRect.height,
            color: Colors.black.withOpacity(0.6),
            alignment: Alignment.center,
            child: SizedBox(
              width: 270,
              height: 66,
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: titleArr.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 60 / 28,
                  ),
                  itemBuilder: (context, index) {
                    String title = titleArr[index];
                    return _buildCellWidget(title, title == resolution);
                  }),
            )),
      ),
    );
  }

  _buildCellWidget(String title, bool selected) {
    return InkWell(
      onTap: () {
        callback(title);
      },
      child: Container(
        alignment: Alignment.center,
          decoration: selected
              ? const BoxDecoration(
                  color: ColorUtils.red233,
                  borderRadius: BorderRadius.all(Radius.circular(14)))
              : BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(14))),
          child: Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400))),
    );
  }
}
