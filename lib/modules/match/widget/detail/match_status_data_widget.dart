import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusDataWidget extends StatefulWidget {
  const MatchStatusDataWidget({super.key});

  @override
  State createState() => _MatchStatusDataWidgetState();
}

class _MatchStatusDataWidgetState extends State<MatchStatusDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildItemWidget(),
        _buildItemWidget(),
        _buildItemWidget(),

        _buildItemWidget(),
        _buildItemWidget(),
        _buildItemWidget(),
      ],
    );
  }

  _buildItemWidget() {
    return Column(
      children: [
        JhAssetImage("common/iconNavBack", width: 12),
        Text("0",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.medium)),
      ],
    );
  }
}
