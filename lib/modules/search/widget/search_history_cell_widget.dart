import 'package:flutter/material.dart';
import 'package:wzty/utils/text_style_utils.dart';

const searchHistoryCellAspect = 80 / 28;

class SearchHistoryCellWidget extends StatefulWidget {
  const SearchHistoryCellWidget({super.key});

  @override
  State createState() => _SearchHistoryCellWidgetState();
}

class _SearchHistoryCellWidgetState extends State<SearchHistoryCellWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: const Text("巴塞罗那",
            style: TextStyle(
                color: Color.fromRGBO(102, 102, 102, 1.0),
                fontSize: 12,
                fontWeight: TextStyleUtils.medium)),
      ),
    );
  }
}
