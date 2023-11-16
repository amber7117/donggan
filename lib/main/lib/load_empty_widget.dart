import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class LoadEmptyWidget extends StatelessWidget {
  final String hintText;
  final String imageAsset;
  final double? imageWidth;
  final double? imageHeight;
  final VoidCallback? callback;

  const LoadEmptyWidget(
      {Key? key,
      this.hintText = '暂无数据',
      this.imageAsset = "common/iconLoadEmpty",
      this.imageWidth = 132,
      this.imageHeight = 132,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtils.gray248,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              JhAssetImage(imageAsset, width: imageWidth, height: imageHeight),
              Text(
                hintText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          const SizedBox(height: 50),
          callback != null
              ? InkWell(
                onTap: callback,
                child: Container(
                    width: 127,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(217, 52, 52, 1),
                            Color.fromRGBO(233, 78, 78, 1)
                          ],
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(21))),
                    child: const Text('重新加载',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
              )
              : const SizedBox(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
