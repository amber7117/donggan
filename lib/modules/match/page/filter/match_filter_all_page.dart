import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/match_filter_entity.dart';
import 'package:wzty/modules/match/widget/filter/match_filter_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchFilterAllPage extends StatefulWidget {
  final MatchFilterModel model;

  const MatchFilterAllPage({super.key, required this.model});

  @override
  State createState() => MatchFilterAllPageState();
}

class MatchFilterAllPageState extends State<MatchFilterAllPage> {

  void selectAllMatch() {
    for (var modelArr in widget.model.moderArrArr) {
      for (var model in modelArr) {
        model.noSelect = false;
      }
    }
    setState(() {
      
    });
  }

  void selectOtherMatch() {
    for (var modelArr in widget.model.moderArrArr) {
      for (var model in modelArr) {
        model.noSelect = !model.noSelect;
      }
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    MatchFilterModel model = widget.model;
    return LoadStateWidget(
        state: model.moderArrArr.isEmpty
            ? LoadStatusType.empty
            : LoadStatusType.success,
        successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    MatchFilterModel model = widget.model;

    if (model.moderArrArr.isEmpty) {
      return const SizedBox();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: model.titleArr.length,
      itemBuilder: (BuildContext context, int index) {
        List<MatchFilterItemModel> itemList = model.moderArrArr[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(model.titleArr[index],
                    style: TextStyle(
                        color: ColorUtils.gray153,
                        fontSize: 14.sp,
                        fontWeight: TextStyleUtils.regual))),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: matchFilterCellAspect,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return MatchFilterCellWidget(model: itemList[index]);
              },
            ),
          ],
        );
      },
    );
  }
}
