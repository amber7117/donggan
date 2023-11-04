import 'package:flutter/material.dart';
import 'package:wzty/common/emoji/emoji_content_widget.dart';
import 'package:wzty/common/emoji/emoji_util.dart';

const emojiWidgetHeight = 250.0;

class EmojiWidget extends StatefulWidget {
  const EmojiWidget({super.key});

  @override
  State createState() => _EmojiWidgetState();
}

class _EmojiWidgetState extends State<EmojiWidget> {
  final List<List<String>> _emojiArr2 = EmojiUtil.obtainEmojiArr2();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 3),
        itemCount: _emojiArr2.length,
        itemExtent: emojiWidgetHeight,
        itemBuilder: (context, index) {
          return EmojiContentWidget(
              dataArr: _emojiArr2[index], callback: (data) {});
        });
  }
}
