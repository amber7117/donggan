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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 120,
      color: Colors.grey,
      alignment: Alignment.center,
      child: Container(
        color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPaiWidget(),
            _buildPaiWidget(),
            _buildPaiWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressDataWidget(),
                const SizedBox(height: 5),
                _buildProgressWidget(),
                const SizedBox(height: 10),
                _buildProgressDataWidget(),
                const SizedBox(height: 5),
                _buildProgressWidget(),
              ],
            ),
            _buildPaiWidget(),
            _buildPaiWidget(),
            _buildPaiWidget(),
          ],
        ),
      ),
    );
  }

  _buildPaiWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        JhAssetImage("common/iconNavBack", width: 12),
        SizedBox(height: 20),
        Text("0",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }

  _buildProgressDataWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("0",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text("射门",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
        Text("0",
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual)),
      ],
    );
  }

  _buildProgressWidget() {
    return Container(
      width: 187,
      height: 6,
      decoration: const BoxDecoration(
          color: ColorUtils.gray248,
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 6,
            decoration: const BoxDecoration(
                color: ColorUtils.red233,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    bottomLeft: Radius.circular(3))),
          ),
          Container(
            width: 40,
            height: 6,
            decoration: const BoxDecoration(
                color: ColorUtils.blue66,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3),
                    bottomRight: Radius.circular(3))),
          )
        ],
      ),
    );
  }
}
