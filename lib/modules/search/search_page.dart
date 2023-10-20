import 'package:flutter/material.dart';
import 'package:wzty/main/lib/appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context: context, titleText: "搜索"),
      body: SizedBox(),
    );
  }
}