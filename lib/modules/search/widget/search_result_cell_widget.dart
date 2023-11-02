import 'package:flutter/material.dart';
import 'package:wzty/common/widget/circle_img_place_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double searchResultCellHeight = 64.0;

class SearchResultCellWidget extends StatefulWidget {
  final AnchorListModel anchor;

  const SearchResultCellWidget({super.key, required this.anchor});

  @override
  State createState() => _SearchResultCellWidgetState();
}

class _SearchResultCellWidgetState extends State<SearchResultCellWidget> {
  @override
  Widget build(BuildContext context) {
    AnchorListModel anchor = widget.anchor;
    return SizedBox(
      height: searchResultCellHeight,
      child: Row(
        children: [
          // const SizedBox(width: 12),
          CircleImgPlaceWidget(
              imgUrl: anchor.headImageUrl,
              width: 44,
              placeholder: "common/iconTouxiang"),
          const SizedBox(width: 10),
          Expanded(
              child: Text(anchor.nickName,
                  style: const TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 14,
                      fontWeight: TextStyleUtils.regual))),
        ],
      ),
    );
  }
}
