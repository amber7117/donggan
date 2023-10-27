import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusDataWidget extends StatefulWidget {
  final MatchStatusFBTechModel? model;

  const MatchStatusDataWidget({super.key, this.model});

  @override
  State createState() => _MatchStatusDataWidgetState();
}

class _MatchStatusDataWidgetState extends State<MatchStatusDataWidget> {
  @override
  Widget build(BuildContext context) {
    MatchStatusFBTechModel? model = widget.model;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 120,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPaiWidget("event/iconZuqiushijianJiaoqiu12",
              (model?.cornerKicks?.team1 ?? 0)),
          _buildPaiWidget("event/iconZuqiushijianHngpai12",
              (model?.redCards?.team1 ?? 0)),
          _buildPaiWidget("event/iconZuqiushijianHuangpai12",
              (model?.yellowCards?.team1 ?? 0)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProgressDataWidget(),
              const SizedBox(height: 5),
              _buildProgressWidget(),
              const SizedBox(height: 10),
              _buildProgressDataWidget(),
              const SizedBox(height: 5),
              _buildProgressWidget(),
            ],
          ),
          _buildPaiWidget("event/iconZuqiushijianHuangpai12",
              (model?.yellowCards?.team2 ?? 0)),
          _buildPaiWidget("event/iconZuqiushijianHngpai12",
              (model?.redCards?.team2 ?? 0)),
          _buildPaiWidget("event/iconZuqiushijianJiaoqiu12",
              (model?.cornerKicks?.team2 ?? 0)),
        ],
      ),
    );
  }

  _buildPaiWidget(String imgPath, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        JhAssetImage(imgPath, width: 12),
        const SizedBox(height: 20),
        Text("$value",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }

  _buildProgressDataWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("0",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text("射门",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text("0",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }

  _buildProgressWidget() {
    return Container(
      width: 187,
      height: 6,
      decoration: const BoxDecoration(
          color: ColorUtils.gray248,
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 6,
            decoration: const BoxDecoration(
                color: ColorUtils.red233,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    bottomLeft: Radius.circular(3))),
          ),
          Container(
            width: 40,
            height: 6,
            decoration: const BoxDecoration(
                color: ColorUtils.blue66,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3),
                    bottomRight: Radius.circular(3))),
          )
        ],
      ),
    );
  }
}
