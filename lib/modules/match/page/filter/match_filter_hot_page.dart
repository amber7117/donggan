import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/match_filter_entity.dart';
import 'package:wzty/modules/match/widget/filter/match_filter_cell_widget.dart';

class MatchFilterHotPage extends StatefulWidget {
  final MatchFilterModel model;

  const MatchFilterHotPage({super.key, required this.model});

  @override
  State createState() => _MatchFilterHotPageState();
}

class _MatchFilterHotPageState extends State<MatchFilterHotPage> {
  @override
  Widget build(BuildContext context) {
    MatchFilterModel model = widget.model;
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: matchFilterCellAspect,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: model.hotArr.length,
      itemBuilder: (BuildContext context, int index) {
        return MatchFilterCellWidget(model: model.hotArr[index]);
      },
    );
  }
}
