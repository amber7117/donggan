import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/match/entity/match_filter_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const matchFilterCellAspect = 110 / 32;

class MatchFilterCellWidget extends StatefulWidget {
  final MatchFilterItemModel model;

  const MatchFilterCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchFilterCellWidgetState();
}

class _MatchFilterCellWidgetState extends State<MatchFilterCellWidget> {
  @override
  Widget build(BuildContext context) {
    MatchFilterItemModel model = widget.model;
    return DecoratedBox(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(250, 250, 250, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(model.cnAlias,
              style: TextStyle(
                  color: const Color.fromRGBO(102, 102, 102, 1.0),
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.medium)),
          const SizedBox(width: 2),
          Text("[${model.matchCount}]",
              style: TextStyle(
                  color: ColorUtils.gray179,
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.medium))
        ],
      ),
    );
  }
}
