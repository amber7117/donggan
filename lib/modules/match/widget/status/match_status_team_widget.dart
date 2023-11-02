import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusTeamWidget extends StatefulWidget {
  final MatchDetailModel detailModel;

  const MatchStatusTeamWidget({super.key, required this.detailModel});

  @override
  State createState() => _MatchStatusTeamWidgetState();
}

class _MatchStatusTeamWidgetState extends State<MatchStatusTeamWidget> {
  @override
  Widget build(BuildContext context) {
    MatchDetailModel model = widget.detailModel;
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          const SizedBox(width: 12),
          buildNetImage(model.hostTeamLogo,
              width: 24, placeholder: "common/logoQiudui"),
          const SizedBox(width: 5),
          SizedBox(
            width: 75,
            child: Text(
              model.hostTeamName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
          const Expanded(
            child: Text(
              "主/客",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
          SizedBox(
            width: 75,
            child: Text(
              model.guestTeamName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ),
          const SizedBox(width: 5),
          buildNetImage(model.guestTeamLogo,
              width: 24, placeholder: "common/logoQiudui"),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
