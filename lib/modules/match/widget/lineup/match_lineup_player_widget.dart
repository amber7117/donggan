import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_info_model.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchLineupPlayerWidget extends StatelessWidget {
  final MatchLineupFBPlayerInfoModel model;

  const MatchLineupPlayerWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 582.0) * 0.5;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: marginY),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildInfoUI(),
          _buildMiddleUI(),
        ],
      ),
    );
  }

  _buildInfoUI() {
    return Row(
      children: [
        CircleImgPlaceWidget(
            imgUrl: model.picUrl,
            width: 58.0,
            placeholder: "common/iconTouxiang"),
        Column(
          children: [
            Text(
              model.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
            Text(
              "${model.age}/${model.height}/${model.weight}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
            Row(
              children: [
                Text(
                  model.positionOften,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual),
                ),
                Text(
                  model.shirtNumber,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  _buildMiddleUI() {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                model.started,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.regual),
              ),
              const Text(
                "赛季首发",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.regual),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                model.winRate,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.regual),
              ),
              const Text(
                "球队胜率",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.regual),
              ),
            ],
          )
        ],
      ),
    );
  }
}
