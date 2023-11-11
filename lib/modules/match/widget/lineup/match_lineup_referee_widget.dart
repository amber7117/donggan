import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_info_model.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MatchLineupRefereeWidget extends StatelessWidget {
  final MatchLineupFBRefereeInfoModel model;
final VoidCallback callback;
  const MatchLineupRefereeWidget({super.key, required this.model, required this.callback});

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 216.0) * 0.5;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: marginY),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoUI(),
          const SizedBox(height: 16),
          _buildMiddleUI(),
          const SizedBox(height: 16),
          const Divider(height: 1, color: ColorUtils.line233),
          Expanded(
            child: InkWell(
              onTap: callback,
              child: SizedBox(
                width: double.infinity,
                child: const Text(
                  "关闭",
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ).alignment(),
              ),
            ),
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
            Row(
              children: [
                Text(
                  "${model.age} ",
                  style: const TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  model.identity,
                  style: const TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                )
              ],
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
                model.yellowCardsPerGame,
                style: const TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              const Text(
                "场均黄牌",
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
                model.redCardsPerGame,
                style: const TextStyle(
                    color: ColorUtils.red233,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              const Text(
                "场均红牌",
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
}
