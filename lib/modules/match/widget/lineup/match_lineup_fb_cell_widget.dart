import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_lineup_fb_model.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchLineupFbCellWidget extends StatefulWidget {
  final MatchLineupFBPlayerModel model;

  const MatchLineupFbCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchLineupFbCellWidgetState();
}

class _MatchLineupFbCellWidgetState extends State<MatchLineupFbCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchLineupFBPlayerModel player = widget.model;
    return SizedBox(
      height: 52,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Container(
            width: 28,
            height: 28,
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              player.shirtNumber,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  player.playerName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              Text(
                player.positionOften,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 10,
                    fontWeight: TextStyleUtils.regual),
              ),
            ],
          )
        ],
      ),
    );
  }
}
