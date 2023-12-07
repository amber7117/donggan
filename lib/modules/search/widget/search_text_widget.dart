import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class SearchTextWidget extends StatefulWidget {
  final WZAnyCallback<String> callback;

  const SearchTextWidget({super.key, required this.callback});

  @override
  State createState() => _SearchTextWidgetState();
}

class _SearchTextWidgetState extends State<SearchTextWidget> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: const BoxDecoration(
          color: ColorUtils.gray248,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const JhAssetImage("common/iconNavSousuo2", width: 20),
          Expanded(
            child: _buildTextField(),
          )
        ],
      ),
    );
  }

  _buildTextField() {
    String hintTxt = "搜索赛事";
    if (ConfigManager.instance.liveOk) {
      hintTxt = "搜索主播、直播或赛事";
    }
    return TextField(
      style: const TextStyle(
        color: ColorUtils.black34,
        fontSize: 12,
        fontWeight: TextStyleUtils.regual,
      ),
      textAlign: TextAlign.left,
      controller: _textController,
      focusNode: _textNode,
      autofocus: true,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onEditingComplete: () {
        if (_textController.text.isNotEmpty) {
          widget.callback(_textController.text);
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        hintText: hintTxt,
        hintStyle: const TextStyle(
          color: ColorUtils.gray179,
          fontSize: 12,
          fontWeight: TextStyleUtils.regual,
        ),
        counterText: '',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.0,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.0,
          ),
        ),
      ),
    );
  }
}
