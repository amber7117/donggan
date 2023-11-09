import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_tech_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusBBDataWidget extends StatelessWidget {
  final MatchStatusBBTechModel? techModel;

  const MatchStatusBBDataWidget({super.key, this.techModel});

  @override
  Widget build(BuildContext context) {
    MatchStatusBBTechModel? model = techModel;

    int hostTwoPointMade = (model?.hostTwoPointMade ?? 0) * 2;
    int hostThrPntMade = (model?.hostThrPntMade ?? 0) * 3;
    int hostPnltyPoint = model?.hostPnltyPoint ?? 0;

    int guestTwoPointMade = (model?.guestTwoPointMade ?? 0) * 2;
    int guestThrPntMade = (model?.guestThrPntMade ?? 0) * 3;
    int guestPnltyPoint = model?.guestPnltyPoint ?? 0;

    return SizedBox(
      width: double.infinity,
      height: 148,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCardWidget("本节犯规", (model?.hostThisFoul ?? 0), true),
              const SizedBox(height: 10),
              _buildCardWidget("剩余暂停", (model?.hostRemainingPause ?? 0), true)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProgressDataWidget(
                  "2分命中", hostTwoPointMade, guestTwoPointMade),
              const SizedBox(height: 5),
              _buildProgressWidget(hostTwoPointMade, guestTwoPointMade),
              const SizedBox(height: 10),
              _buildProgressDataWidget("3分命中", hostThrPntMade, guestThrPntMade),
              const SizedBox(height: 5),
              _buildProgressWidget(hostThrPntMade, guestThrPntMade),
              const SizedBox(height: 10),
              _buildProgressDataWidget("罚球命中", hostPnltyPoint, guestPnltyPoint),
              const SizedBox(height: 5),
              _buildProgressWidget(hostPnltyPoint, guestPnltyPoint),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCardWidget("本节犯规", (model?.hostThisFoul ?? 0), false),
              const SizedBox(height: 10),
              _buildCardWidget("剩余暂停", (model?.hostRemainingPause ?? 0), false)
            ],
          ),
        ],
      ),
    );
  }

  _buildCardWidget(String title, int value, bool isHost) {
    return Container(
      width: 64,
      height: 48,
      decoration: BoxDecoration(
          color: isHost
              ? ColorUtils.red233.withOpacity(0.05)
              : ColorUtils.blue66.withOpacity(0.05),
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title,
            style: const TextStyle(
                color: ColorUtils.red233,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual)),
        const SizedBox(height: 5),
        Text("$value",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 14,
                fontWeight: TextStyleUtils.medium)),
      ]),
    );
  }

  _buildProgressDataWidget(String title, int team1, int team2) {
    Color team1Color;
    Color team2Color;
    if (team1 > team2) {
      team1Color = ColorUtils.black34;
      team2Color = ColorUtils.gray153;
    } else if (team1 < team2) {
      team1Color = ColorUtils.gray153;
      team2Color = ColorUtils.black34;
    } else {
      team1Color = ColorUtils.black34;
      team2Color = ColorUtils.black34;
    }

    return SizedBox(
      width: 187.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$team1",
              style: TextStyle(
                  color: team1Color,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual)),
          Text(title,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual)),
          Text("$team2",
              style: TextStyle(
                  color: team2Color,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual)),
        ],
      ),
    );
  }

  _buildProgressWidget(int team1, int team2) {
    Color team1Color;
    Color team2Color;
    if (team1 > team2) {
      team1Color = const Color.fromRGBO(233, 78, 78, 1.0);
      team2Color = const Color.fromRGBO(66, 191, 244, 0.2);
    } else if (team1 < team2) {
      team1Color = const Color.fromRGBO(233, 78, 78, 0.2);
      team2Color = const Color.fromRGBO(66, 191, 244, 1.0);
    } else {
      team1Color = const Color.fromRGBO(233, 78, 78, 1.0);
      team2Color = const Color.fromRGBO(66, 191, 244, 1.0);
    }
    double width = 187.w;
    double widthHalf = width * 0.5;
    double team1Width = 0.0;
    double team2Width = 0.0;
    if (team1 > 0 || team2 > 0) {
      team1Width = widthHalf * (team1 / (team1 + team2));
      team2Width = widthHalf * (team2 / (team1 + team2));
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
