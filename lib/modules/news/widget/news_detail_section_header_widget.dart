import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

enum NewsDetailSectionHeaderType {
  news,
  comment,
}

class NewsDetailSectionHeaderWidget extends StatefulWidget {
  final NewsDetailSectionHeaderType type;

  const NewsDetailSectionHeaderWidget({super.key, required this.type});

  @override
  State createState() => _NewsDetailSectionHeaderWidgetState();
}

class _NewsDetailSectionHeaderWidgetState
    extends State<NewsDetailSectionHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.type == NewsDetailSectionHeaderType.news
            ? const SizedBox(height: 0)
            : const SizedBox(height: 8),
        const SizedBox(width: double.infinity, height: 0.5)
            .colored(ColorUtils.gray229),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 13, bottom: 13, left: 14, right: 8),
                child: JhAssetImage(
                    widget.type == NewsDetailSectionHeaderType.news
                        ? "news/iconZixunXgwz"
                        : "news/iconZixunQbpl",
                    width: 18)),
            Text(
              widget.type == NewsDetailSectionHeaderType.news ? "相关文章" : "全部评论",
              style: const TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 14,
                  fontWeight: TextStyleUtils.bold),
            ),
          ],
        ),
        const SizedBox(width: double.infinity, height: 0.5)
            .colored(ColorUtils.gray229),
      ],
    );
  }
}
