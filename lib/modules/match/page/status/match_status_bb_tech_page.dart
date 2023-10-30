import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_bb_tech_entity.dart';

class MatchStatusBbTechPage extends StatefulWidget {
  final MatchDetailModel detailModel;
  final MatchStatusBBTechModel? techModel;
  
  const MatchStatusBbTechPage({super.key, required this.detailModel, this.techModel});


  @override
  State createState() => _MatchStatusBbTechPageState();
}

class _MatchStatusBbTechPageState extends State<MatchStatusBbTechPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}