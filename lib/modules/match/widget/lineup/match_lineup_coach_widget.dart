import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_info_model.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MatchLineupCoachWidget extends StatelessWidget {
  final MatchLineupFBCoachInfoModel model;

  const MatchLineupCoachWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 216.0) * 0.5;

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
              model.careerStartEnd,
              style: const TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
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
                      color: ColorUtils.red233,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
        const Spacer(),
        buildNetImage(model.teamLogo,
            width: 44, height: 44, placeholder: "common/logoQiudui"),
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
                model.count,
                style: const TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              const Text(
                "执教场次",
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
}
