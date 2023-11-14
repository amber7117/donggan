import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/emoji/emoji_content_widget.dart';
import 'package:wzty/common/emoji/emoji_util.dart';
import 'package:wzty/utils/color_utils.dart';

const emojiWidgetHeight = 230.0;

class EmojiWidget extends StatefulWidget {
  final WZAnyCallback<String> callback;

  const EmojiWidget({super.key, required this.callback});

  @override
  State createState() => _EmojiWidgetState();
}

class _EmojiWidgetState extends State<EmojiWidget> {
  final List<List<String>> _emojiArr2 = EmojiUtil.obtainEmojiArr2();

  int _current = 0;
  final ScrollController _controller = ScrollController();

  final double pageWidth = ScreenUtil().screenWidth;
  final double pageWidthHalf = ScreenUtil().screenWidth * 0.5;

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      int page = _controller.offset ~/ pageWidth;
      double offset = _controller.offset - pageWidth * page;
      if (offset > pageWidthHalf) {
        page++;
      }

      logger.d("EmojiWidget page --------- $page ");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: emojiWidgetHeight + ScreenUtil().bottomBarHeight,
      child: Stack(
        alignment: Alignment.bottomRight, children: [
        ListView.builder(
            padding: const EdgeInsets.only(top: 3),
            itemCount: _emojiArr2.length,
            itemExtent: pageWidth,
            controller: _controller,
            physics: const PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            cacheExtent: 0.0,
            itemBuilder: (context, index) {
              return EmojiContentWidget(
                  dataArr: _emojiArr2[index], callback: (data) {
                    widget.callback(data);
                  });
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _emojiArr2.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateTo(
                pageWidth,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
