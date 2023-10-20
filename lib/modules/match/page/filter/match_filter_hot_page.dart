import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/match_filter_entity.dart';
import 'package:wzty/modules/match/widget/filter/match_filter_cell_widget.dart';

class MatchFilterHotPage extends StatefulWidget {
  final MatchFilterModel model;

  const MatchFilterHotPage({super.key, required this.model});

  @override
  State createState() => MatchFilterHotPageState();
}

class MatchFilterHotPageState extends State<MatchFilterHotPage> {

  void selectAllMatch() {
    for (var model in widget.model.hotArr) {
      model.noSelect = false;
    }
    setState(() {
      
    });
  }

  void selectOtherMatch() {
    for (var model in widget.model.hotArr) {
      model.noSelect = !model.noSelect;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    MatchFilterModel model = widget.model;
    return LoadStateWidget(
        state: model.hotArr.isEmpty
            ? LoadStatusType.empty
            : LoadStatusType.success,
        successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    MatchFilterModel model = widget.model;

    if (model.hotArr.isEmpty) {
      return const SizedBox();
    }

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
