import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/modules/match/entity/match_detail_entity.dart';
import 'package:wzty/modules/match/provider/matc_detail_provider.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchDetailHeadWidget extends StatefulWidget {
  final double height;
  final MatchDetailModel model;

  const MatchDetailHeadWidget(
      {super.key, required this.height, required this.model});

  @override
  State createState() => _MatchDetailHeadWidgetState();
}

class _MatchDetailHeadWidgetState extends State<MatchDetailHeadWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height + ScreenUtil().statusBarHeight,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image:
                  JhImageUtils.getAssetImage("match/imgZuqiuBg", x2: false))),
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
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
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: TextStyleUtils.medium),
            ),
            Text(
              model.matchTimeNew,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.regual),
            ),
          ],
        ),
        InkWell(
          child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              child:
                  const JhAssetImage("match/iconStar", width: 24, height: 24)),
          onTap: () {},
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
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.medium),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "2 - 2",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
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
                  Text(
                    "动画",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: TextStyleUtils.regual),
                  ).inkWell(() {
                    context.read<MatchDetailProvider>().setShowAnimate(true);
                  }),
                  const SizedBox(width: 10),
                  const SizedBox(width: 0.5, height: 8).colored(Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    "视频",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: TextStyleUtils.regual),
                  ).inkWell(() {
                    context.read<MatchDetailProvider>().setShowVideo(true);
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
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.medium),
            ),
          ],
        ),
      ],
    );
  }
}
