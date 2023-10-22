import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/banner/entity/banner_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';

const liveBannerHeight = 162.0;

class AnchorBannerWidget extends StatefulWidget {
  final List<BannerModel> bannerArr;

  const AnchorBannerWidget({super.key, required this.bannerArr});

  @override
  State createState() => _AnchorBannerWidgetState();
}

class _AnchorBannerWidgetState extends State<AnchorBannerWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    List<BannerModel> bannerArr = widget.bannerArr;

    return SizedBox(
      width: double.infinity,
      height: liveBannerHeight,
      child: Stack(alignment: Alignment.bottomRight, children: [
        CarouselSlider(
          items: bannerArr.map((model) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    model.jump();
                  },
                  child: buildNetImage(model.img,
                    width: ScreenUtil().screenWidth,
                    height: liveBannerHeight,
                    placeholder: "common/imgZhiboMoren",
                    fit: BoxFit.cover),
                );
              },
            );
          }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
              height: liveBannerHeight,
              viewportFraction: 1.0,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerArr.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? ColorUtils.red235
                        : Colors.black.withOpacity(0.2)),
              ),
            );
          }).toList(),
        )
      ]),
    );
  }
}
