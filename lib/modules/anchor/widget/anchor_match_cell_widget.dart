import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const liveMatchCellHeight = 99.0;
const liveMatchCellRatio = 162 / 99;

class AnchorMatchCellWidget extends StatefulWidget {
  final MatchListModel model;

  const AnchorMatchCellWidget({super.key, required this.model});

  @override
  State createState() => _AnchorMatchCellWidgetState();
}

class _AnchorMatchCellWidgetState extends State<AnchorMatchCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchListModel model = widget.model;

    return InkWell(
      onTap: () {
        Routes.push(context, Routes.matchDetail, arguments: model.matchId);
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(180, 180, 180, 0.2), // 阴影颜色
                spreadRadius: 0, // 阴影扩散程度
                blurRadius: 6, // 阴影模糊程度
                offset: Offset(0, 2), // 阴影偏移量
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            _buildTeamInfoWidget(
                model.hostTeamLogo, model.hostTeamName, model.hostTeamScore),
            _buildTeamInfoWidget(
                model.guestTeamLogo, model.guestTeamName, model.guestTeamScore),
          ],
        ),
      ),
    );
  }

  _buildTeamInfoWidget(String logo, String name, int score) {
    return Row(
      children: [
        buildNetImage(logo, width: 20, placeholder: "common/logoQiudui"),
        Expanded(
            child: SizedBox(
              width: 70.w,
              child: Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 12.sp,
                      fontWeight: TextStyleUtils.medium)),
            )),
        Text("$score",
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 14.sp,
                fontWeight: TextStyleUtils.semibold)),
      ],
    );
  }
}
