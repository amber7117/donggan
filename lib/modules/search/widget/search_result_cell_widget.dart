import 'package:flutter/material.dart';

class SearchResultCellWidget extends StatefulWidget {
  const SearchResultCellWidget({super.key});

  @override
  State createState() => _SearchResultCellWidgetState();
}

class _SearchResultCellWidgetState extends State<SearchResultCellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.yellow,
    );
  }
}