import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/text_style_utils.dart';

const searchHistoryCellAspect = 80 / 28;

class SearchHistoryCellWidget extends StatefulWidget {
  final String keyWord;
  final WZAnyCallback callback;

  const SearchHistoryCellWidget(
      {super.key, required this.keyWord, required this.callback});

  @override
  State createState() => _SearchHistoryCellWidgetState();
}

class _SearchHistoryCellWidgetState extends State<SearchHistoryCellWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.callback(widget.keyWord);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Text(widget.keyWord,
            style: const TextStyle(
                color: Color.fromRGBO(102, 102, 102, 1.0),
                fontSize: 12,
                fontWeight: TextStyleUtils.medium)),
      ),
    );
  }
}
