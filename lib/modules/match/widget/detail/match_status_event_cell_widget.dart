import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double statusEventCellHeight = 40.0;

class MatchStatusEventCellWidget extends StatefulWidget {
  final MatchStatusFBEventModel model;

  const MatchStatusEventCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchStatusEventCellWidgetState();
}

class _MatchStatusEventCellWidgetState
    extends State<MatchStatusEventCellWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildLeftContent(context);
  }

  _buildLeftContent(BuildContext context) {
    MatchStatusFBEventModel model = widget.model;
    return Container(
      color: const Color.fromRGBO(250, 250, 250, 1.0),
      margin: EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      child: Row(
        children: [
          const SizedBox(width: 10),
          JhAssetImage("event/iconZuqiushijianHuangpai16", width: 16),
          const SizedBox(width: 5),
          Text(
            "${model.occurTime ~/ 60}'",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          const SizedBox(width: 15),
          Text(
            model.playerName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Color.fromARGB(255, 35, 28, 28),
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          Text(
            model.content,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          const SizedBox(width: 3),
          JhAssetImage("event/iconZuqiushijianHuangpai12", width: 12),
        ],
      ),
    );
  }

  _buildRightContent(BuildContext context) {}
}
