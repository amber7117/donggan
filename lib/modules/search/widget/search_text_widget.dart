import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class SearchTextWidget extends StatefulWidget {
  const SearchTextWidget({super.key});

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
          SizedBox(width: 10),
          JhAssetImage("common/iconNavSousuo2", width: 20),
          Expanded(
            child: _buildTextField(),
          )
        ],
      ),
    );
  }

  _buildTextField() {
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
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        hintText: "搜索用户、直播或赛事",
        hintStyle: TextStyle(
          color: ColorUtils.gray179,
          fontSize: 12.sp,
          fontWeight: TextStyleUtils.regual,
        ),
        counterText: '',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
