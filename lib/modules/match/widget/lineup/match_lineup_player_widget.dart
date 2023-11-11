import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_info_model.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MatchLineupPlayerWidget extends StatelessWidget {
  final MatchLineupFBPlayerInfoModel model;

  const MatchLineupPlayerWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 582.0) * 0.5;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: marginY),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoUI(),
          const SizedBox(height: 20),
          _buildMiddleUI(),
          const SizedBox(height: 10),
          const Text(
            "本场数据统计",
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: model.itemArr2.length,
                itemBuilder: (context, index) {
                  List<MatchLineupFBPlayerInfoItemModel> itemArr =
                      model.itemArr2[index];
                  return Column(
                    children: [
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: itemArr.length,
                          itemExtent: 28.0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildItemWidget(itemArr[index]);
                          }),
                      Container(
                        width: double.infinity,
                        height: 32,
                        alignment: Alignment.center,
                        child:
                            const SizedBox(width: double.infinity, height: 0.5)
                                .colored(ColorUtils.line233),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  _buildInfoUI() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleImgPlaceWidget(
                imgUrl: model.picUrl,
                width: 58.0,
                placeholder: "common/iconTouxiang"),
            buildNetImage(model.countryPicUrl, width: 20, height: 14),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${model.age} / ${model.height} / ${model.weight}",
              style: const TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Text(
                  "${model.positionOften} ",
                  style: const TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  model.shirtNumber,
                  style: const TextStyle(
                      color: ColorUtils.red233,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
        const Spacer(),
        Column(
          children: [
            Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: ColorUtils.red233,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Text(
                  model.rating,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                )),
            const SizedBox(height: 5),
            const Text(
              "本场评分",
              style: TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 9,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ],
    );
  }

  _buildMiddleUI() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(250, 250, 250, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.started,
                style: const TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              const Text(
                "赛季首发",
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 9,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(width: 1, height: 22).colored(ColorUtils.line233),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.winRate,
                style: const TextStyle(
                    color: ColorUtils.red233,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              const Text(
                "球队胜率",
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 9,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildItemWidget(MatchLineupFBPlayerInfoItemModel itemModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(itemModel.name,
            style: const TextStyle(
                color: Color.fromRGBO(102, 102, 102, 1),
                fontSize: 12,
                fontWeight: FontWeight.w500)),
        Text(itemModel.value,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: FontWeight.w700))
      ],
    );
  }
}
