import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/widget/match_cell_widget.dart';
import 'package:wzty/modules/search/entity/search_entity.dart';
import 'package:wzty/modules/search/widget/search_result_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class SearchResultPage extends StatefulWidget {
  final LoadStatusType layoutState;
  final SearchResultModel model;

  const SearchResultPage(
      {super.key, required this.layoutState, required this.model});

  @override
  State createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return LoadStateWidget(
        state: widget.layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    SearchResultModel model = widget.model;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 12, left: 12),
                  child: Text("相关主播",
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 14,
                          fontWeight: TextStyleUtils.semibold))),
              ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: model.anchors.length,
                  itemExtent: searchResultCellHeight,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SearchResultCellWidget(anchor: model.anchors[index]);
                  }),
            ],
          ).colored(Colors.white);
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 12, left: 12),
                  child: Text("相关赛事",
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 14,
                          fontWeight: TextStyleUtils.semibold))),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: model.matchList.length,
                  itemExtent: matchChildCellHeight,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MatchCellWidget(listModel: model.matchList[index]);
                  }),
            ],
          );
        }
      },
    ).colored(ColorUtils.gray248);
  }
}
