import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/widget/anchor_cell_widget.dart';
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
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 12),
                child: Text("主播",
                    style: const TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 14,
                        fontWeight: TextStyleUtils.semibold))),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: anchorCellRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 9,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return SearchResultCellWidget();
              },
            ),
          ],
        );
      },
    );
  }
}
