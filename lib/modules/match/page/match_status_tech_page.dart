import 'package:flutter/material.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';
import 'package:wzty/modules/match/widget/detail/match_status_tech_cell_widget.dart';

class MatchStatusTechPage extends StatefulWidget {
  final MatchStatusFBTechModel? techModel;
  const MatchStatusTechPage({super.key, this.techModel});

  @override
  State createState() => _MatchStatusTechPageState();
}

class _MatchStatusTechPageState extends State<MatchStatusTechPage> {
  LoadStatusType _layoutState = LoadStatusType.success;

  @override
  Widget build(BuildContext context) {
    if (widget.techModel == null || widget.techModel!.dataModelArr.isEmpty) {
      _layoutState = LoadStatusType.empty;
    }
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    MatchStatusFBTechModel techModel = widget.techModel!;
    return ColoredBox(
      color: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 3),
          itemCount: techModel.dataModelArr.length + 1,
          itemExtent: 100,
          itemBuilder: (context, index) {
            return MatchStatusTechCellWidget(
                model: techModel.dataModelArr[index]);
          }),
    );
  }
}
