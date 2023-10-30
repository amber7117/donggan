import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double statusTechCellHeight = 50.0;

class MatchStatusFBTechCellWidget extends StatefulWidget {
  final MatchStatusFBTechLocalModel model;

  const MatchStatusFBTechCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchStatusFBTechCellWidgetState();
}

class _MatchStatusFBTechCellWidgetState extends State<MatchStatusFBTechCellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      width: double.infinity,
      height: statusTechCellHeight,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProgressDataWidget(),
          const SizedBox(height: 5),
          _buildProgressWidget()
        ],
      ),
    );
  }

  _buildProgressDataWidget() {
    MatchStatusFBTechLocalModel model = widget.model;
    Color team1Color;
    Color team2Color;
    if (model.team1 > model.team2) {
      team1Color = ColorUtils.black34;
      team2Color = ColorUtils.gray153;
    } else if (model.team1 < model.team2) {
      team1Color = ColorUtils.gray153;
      team2Color = ColorUtils.black34;
    } else {
      team1Color = ColorUtils.black34;
      team2Color = ColorUtils.black34;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${model.team1}",
            style: TextStyle(
                color: team1Color,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text(model.title,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text("${model.team2}",
            style: TextStyle(
                color: team2Color,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }

  _buildProgressWidget() {
    MatchStatusFBTechLocalModel model = widget.model;
    Color team1Color;
    Color team2Color;
    if (model.team1 > model.team2) {
      team1Color = const Color.fromRGBO(233, 78, 78, 1.0);
      team2Color = const Color.fromRGBO(66, 191, 244, 0.2);
    } else if (model.team1 < model.team2) {
      team1Color = const Color.fromRGBO(233, 78, 78, 0.2);
      team2Color = const Color.fromRGBO(66, 191, 244, 1.0);
    } else {
      team1Color = const Color.fromRGBO(233, 78, 78, 1.0);
      team2Color = const Color.fromRGBO(66, 191, 244, 1.0);
    }
    double width = 320.w;
    double widthHalf = width * 0.5;
    double team1Width = 0.0;
    double team2Width = 0.0;
    if (model.team1 > 0 || model.team2 > 0) {
      team1Width = widthHalf * (model.team1 / (model.team1 + model.team2));
      team2Width = widthHalf * (model.team2 / (model.team1 + model.team2));
    }

    return Container(
      width: width,
      height: 6,
      decoration: const BoxDecoration(
          color: ColorUtils.gray248,
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: widthHalf,
              alignment: Alignment.centerRight,
              child: SizedBox(width: team1Width, height: 6).decorate(
                BoxDecoration(
                    color: team1Color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3))),
              )),
          Container(
              width: widthHalf,
              alignment: Alignment.centerLeft,
              child: SizedBox(width: team2Width, height: 6).decorate(
                BoxDecoration(
                    color: team2Color,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3))),
              )),
        ],
      ),
    );
  }
}
