import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_tech_entity.dart';

const double statusTechCellHeight = 50.0;

class MatchStatusTechCellWidget extends StatefulWidget {
  final MatchStatusFBTechLocalModel model;

  const MatchStatusTechCellWidget({super.key, required this.model});

  @override
  State createState() => _MatchStatusTechCellWidgetState();
}

class _MatchStatusTechCellWidgetState extends State<MatchStatusTechCellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}