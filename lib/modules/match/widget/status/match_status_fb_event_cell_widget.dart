import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double statusFBEventCellHeight = 40.0;

class MatchStatusFBEventCellWidget extends StatefulWidget {
  final MatchStatusFBEventModel model;

  const MatchStatusFBEventCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchStatusFBEventCellWidgetState();
}

class _MatchStatusFBEventCellWidgetState
    extends State<MatchStatusFBEventCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchStatusFBEventModel model = widget.model;
    String imgPath1 = AppBusinessUtils.obtainStatusEventPic(model.typeId);
    String? imgPath2;
    String text1;
    String text2;

    String time = "${model.occurTime ~/ 60}'";

    if (model.typeId == 9) {
      //进球
      if (model.team == 1) {
        text1 = "${model.playerName}${model.content2}";
      } else {
        text1 = "${model.content2}${model.playerName}";
      }

      if (model.playerName2.isNotEmpty) {
        text2 = "（助攻/${model.playerName2}）";

        imgPath2 = "event/iconZuqiushijianZhugong12";
      } else {
        text2 = "";
      }
    } else if (model.typeId == 18) {
      //黄牌
      text1 = model.playerName;
      text2 = model.content;
    } else if (model.typeId == 22) {
      //红牌
      text1 = model.playerName;
      text2 = model.content;
    } else if (model.typeId == 23) {
      //换人
      text1 = model.playerName;
      text2 = "（换下/${model.playerName2}）";

      imgPath2 = "event/iconZuqiushijianHuanrenDown12";
    } else if (model.typeId == 30) {
      //角球
      text1 = model.content;
      text2 = model.content2;
    } else {
      text1 = model.content;
      text2 = model.content2;
    }

    if (model.team == 1) {
      return _buildLeftContent(
          model.idx, time, imgPath1, imgPath2, text1, text2);
    } else {
      return _buildRightContent(
          model.idx, time, imgPath1, imgPath2, text1, text2);
    }
  }

  _buildLeftContent(int idx, String time, String imgPath1, String? imgPath2,
      String text1, String text2) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: idx > 0
          ? const BoxDecoration(
              color: Color.fromRGBO(250, 250, 250, 1.0),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            )
          : const BoxDecoration(
              color: Color.fromRGBO(250, 250, 250, 1.0),
            ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          JhAssetImage(imgPath1, width: 16),
          const SizedBox(width: 5),
          Text(
            time,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          const SizedBox(width: 5),
          Text(
            text1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Color.fromARGB(255, 35, 28, 28),
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          Text(
            text2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          const SizedBox(width: 3),
          imgPath2 == null
              ? const SizedBox()
              : JhAssetImage(imgPath2, width: 12),
        ],
      ),
    );
  }

  _buildRightContent(int idx, String time, String imgPath1, String? imgPath2,
      String text1, String text2) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: idx > 0
          ? const BoxDecoration(
              color: Color.fromRGBO(250, 250, 250, 1.0),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            )
          : const BoxDecoration(
              color: Color.fromRGBO(250, 250, 250, 1.0),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          imgPath2 == null
              ? const SizedBox()
              : JhAssetImage(imgPath2, width: 12),
          const SizedBox(width: 3),
          Text(
            text2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          Text(
            text1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Color.fromARGB(255, 35, 28, 28),
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          const SizedBox(width: 5),
          Text(
            time,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          const SizedBox(width: 5),
          JhAssetImage(imgPath1, width: 16),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
