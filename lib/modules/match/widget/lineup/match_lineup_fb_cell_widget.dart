import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_model.dart';
import 'package:wzty/utils/app_business_utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchLineupFbCellWidget extends StatelessWidget {
  final MatchLineupFBPlayerModel model;
  final bool isHost;

  const MatchLineupFbCellWidget(
      {super.key, required this.model, required this.isHost});

  @override
  Widget build(BuildContext context) {
    String imgPath;
    if (isHost) {
      imgPath = "match/iconPlayerRed";
    } else {
      imgPath = "match/iconPlayerBlue";
    }

    return SizedBox(
      height: 52,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: JhImageUtils.getAssetImage(imgPath),
                  fit: BoxFit.fitWidth),
            ),
            child: Text(
              model.shirtNumber,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: TextStyleUtils.medium),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  model.playerName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              Text(
                model.positionOften,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 10,
                    fontWeight: TextStyleUtils.regual),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _buildEventUI(),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  List<Widget> _buildEventUI() {
    List<Widget> rowChildren = [];

    for (MatchLineupFBEventModel eventModel in model.eventList) {
      String imgPath1 =
          AppBusinessUtils.obtainLineupEventPic(eventModel.resetTypeId);
      if (imgPath1.isEmpty) {
        continue;
      }

      if (eventModel.resetTypeId == 8 || eventModel.resetTypeId == 9) {
        Widget label = Text(
          "${eventModel.time ~/ 60}'",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: ColorUtils.gray153,
              fontSize: 10,
              fontWeight: TextStyleUtils.regual),
        );

        rowChildren.add(label);
      }

      Widget img = JhAssetImage(imgPath1, width: 12);
      rowChildren.add(img);
    }

    return rowChildren;
  }
}
