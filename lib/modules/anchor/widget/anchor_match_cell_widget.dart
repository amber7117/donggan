import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/modules/match/entity/match_list_entity.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

const liveMatchCellHeight = 99.0;
const liveMatchCellWidth = 161.0;
const liveMatchCellRatio = 99.0 / 161.0;

class AnchorMatchCellWidget extends StatefulWidget {
  final MatchListModel model;

  const AnchorMatchCellWidget({super.key, required this.model});

  @override
  State createState() => _AnchorMatchCellWidgetState();
}

class _AnchorMatchCellWidgetState extends State<AnchorMatchCellWidget> {

  _requestMatchBook() {
    MatchListModel model = widget.model!;
    bool isBook = !model.userIsAppointment;

    ToastUtils.showLoading();

    MatchService.requestMatchBook(model.matchId, isBook, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        ToastUtils.showSuccess(isBook ? "预约成功" : "取消预约成功");
        model.userIsAppointment = isBook;

        setState(() {});
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MatchListModel model = widget.model;
    MatchStatus matchStatus = matchStatusFromServerValue(model.status);
    bool showScore = false;
    if (matchStatus == MatchStatus.going) {
      showScore = true;
    }

    return InkWell(
      onTap: () {
        Routes.push(context, Routes.matchDetail, arguments: model.matchId);
      },
      child: Container(
        height: liveMatchCellHeight, //这里属性没用
        margin: const EdgeInsets.only(right: 12),
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
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(217, 232, 255, 1.0),
                      Color.fromRGBO(255, 211, 218, 1.0)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.leagueName,
                        style: const TextStyle(
                            color: Color.fromRGBO(98, 135, 194, 1.0),
                            fontSize: 10,
                            fontWeight: TextStyleUtils.medium)),
                    const Text("LIVE",
                        style: TextStyle(
                            color: ColorUtils.red235,
                            fontSize: 10,
                            fontWeight: TextStyleUtils.medium)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTeamInfoWidget(
                            model.hostTeamLogo, model.hostTeamName),
                        const SizedBox(height: 8),
                        _buildTeamInfoWidget(
                            model.guestTeamLogo, model.guestTeamName),
                      ],
                    ),
                  ),
                  showScore
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${model.hostTeamScore}",
                                style: const TextStyle(
                                    color: ColorUtils.black34,
                                    fontSize: 14,
                                    fontWeight: TextStyleUtils.semibold)),
                            const SizedBox(height: 8),
                            Text("${model.guestTeamScore}",
                                style: const TextStyle(
                                    color: ColorUtils.black34,
                                    fontSize: 14,
                                    fontWeight: TextStyleUtils.semibold)),
                          ],
                        )
                      : InkWell(
                          onTap: _requestMatchBook,
                          child: JhAssetImage(
                              model.userIsAppointment
                                  ? "anchor/icon_bookS"
                                  : "anchor/icon_book",
                              width: 24)),
                  const SizedBox(width: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTeamInfoWidget(String logo, String name) {
    return Row(
      children: [
        const SizedBox(width: 10),
        buildNetImage(logo, width: 20, placeholder: "common/logoQiudui"),
        const SizedBox(width: 8),
        SizedBox(
          width: 70.w,
          child: Text(name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.medium)),
        ),
      ],
    );
  }
}
