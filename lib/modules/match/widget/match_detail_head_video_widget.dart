import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/match_detail_entity.dart';

class MatchDetailHeadVideoWidget extends StatefulWidget {
  
  final double height;
  final MatchDetailModel model;

  const MatchDetailHeadVideoWidget(
      {super.key, required this.height, required this.model});

  @override
  State createState() => _MatchDetailHeadVideoWidgetState();
}

class _MatchDetailHeadVideoWidgetState
    extends State<MatchDetailHeadVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
