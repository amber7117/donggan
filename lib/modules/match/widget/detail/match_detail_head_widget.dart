import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/provider/match_detail_data_provider.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MatchDetailHeadWidget extends StatefulWidget {
  final double height;
  final MatchDetailModel model;

  const MatchDetailHeadWidget(
      {super.key, required this.height, required this.model});

  @override
  State createState() => _MatchDetailHeadWidgetState();
}

class _MatchDetailHeadWidgetState extends State<MatchDetailHeadWidget> {
  void _requestMatchCollect() {
    if (!UserManager.instance.isLogin()) {
      Routes.goLoginPage(context);
      return;
    }

    MatchDetailModel model = widget.model;
    bool isAdd = !model.focus.isTrue();

    ToastUtils.showLoading();

    SportType sportType = SportType.football;
    if (widget.model.sportId == SportType.basketball.value) {
      sportType = SportType.basketball;
    }

    MatchService.requestMatchCollect(sportType, model.matchId, isAdd,
        (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        ToastUtils.showSuccess(isAdd ? "收藏成功" : "取消收藏成功");
        model.focus = isAdd.toInt();

        // int cnt = MatchCollectManager.instance
        //     .updateCollectData(widget.sportType, model);

        // context.read<TabDotProvider>().setDotNum(cnt);

        setState(() {});
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String imgPath;
    if (widget.model.sportId == SportType.football.value) {
      imgPath = "match/imgZuqiuBg";
    } else {
      imgPath = "match/imgLanqiuBg";
    }

    return Container(
      height: widget.height + ScreenUtil().statusBarHeight,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image: JhImageUtils.getAssetImage(imgPath, x2: false))),
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          _buildNavWidget(),
          const SizedBox(height: 7),
          Container(
              width: 44,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Text(
                widget.model.matchStatusDesc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.medium),
              )),
          const SizedBox(height: 16),
          _buildTeamWidget(),
        ],
      ),
    );
  }

  _buildNavWidget() {
    MatchDetailModel model = widget.model;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const WZBackButton(),
        Column(
          children: [
            Text(
              model.leagueName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: TextStyleUtils.medium),
            ),
            Text(
              model.matchTimeNew,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
          ],
        ),
        InkWell(
          onTap: _requestMatchCollect,
          child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              child: JhAssetImage(
                  model.focus.isTrue() ? "match/iconStarS" : "match/iconStar",
                  width: 24,
                  height: 24)),
        )
      ],
    );
  }

  _buildTeamWidget() {
    MatchDetailModel model = widget.model;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 38, right: 38, bottom: 12),
                child: buildNetImage(model.hostTeamLogo,
                    width: 50, placeholder: "common/logoQiudui")),
            Text(
              model.hostTeamName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.medium),
            ),
          ],
        ),
        Column(
          children: [
            const Text(
              "2 - 2",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: TextStyleUtils.semibold),
            ),
            Container(
              width: 80,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "动画",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: TextStyleUtils.regual),
                  ).inkWell(() {
                    context
                        .read<MatchDetailDataProvider>()
                        .setShowAnimate(true);
                  }),
                  const SizedBox(width: 10),
                  const SizedBox(width: 0.5, height: 8).colored(Colors.white),
                  const SizedBox(width: 10),
                  const Text(
                    "视频",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: TextStyleUtils.regual),
                  ).inkWell(() {
                    context.read<MatchDetailDataProvider>().setShowVideo(true);
                  }),
                ],
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 38, right: 38, bottom: 12),
                child: buildNetImage(model.guestTeamLogo,
                    width: 50, placeholder: "common/logoQiudui")),
            Text(
              model.guestTeamName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.medium),
            ),
          ],
        ),
      ],
    );
  }
}
