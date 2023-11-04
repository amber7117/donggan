import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class EmojiContentWidget extends StatelessWidget {
  final List<String> dataArr;
  final WZAnyCallback callback;

  const EmojiContentWidget(
      {super.key, required this.dataArr, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        childAspectRatio: 1.0,
        mainAxisSpacing: 10,
        crossAxisSpacing: 9,
      ),
      itemCount: dataArr.length,
      itemBuilder: (BuildContext context, int index) {
        String emojiStr = dataArr[index];
        if (emojiStr == "iconDelete") {
          return Text(emojiStr,
              style: const TextStyle(
                  color: ColorUtils.black51,
                  fontSize: 15,
                  fontWeight: TextStyleUtils.regual));
        } else {
          return Text(emojiStr,
              style: const TextStyle(
                  color: ColorUtils.black51,
                  fontSize: 15,
                  fontWeight: TextStyleUtils.regual));
        }
      },
    );
  }
}
