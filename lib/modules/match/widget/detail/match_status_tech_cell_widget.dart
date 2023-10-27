import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double statusTechCellHeight = 50.0;

class MatchStatusTechCellWidget extends StatefulWidget {
  final MatchStatusFBTechLocalModel model;

  const MatchStatusTechCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchStatusTechCellWidgetState();
}

class _MatchStatusTechCellWidgetState extends State<MatchStatusTechCellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: statusTechCellHeight,
      color: Colors.grey,
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
