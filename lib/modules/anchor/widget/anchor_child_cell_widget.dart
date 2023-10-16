import 'package:flutter/material.dart';
import 'package:wzty/modules/anchor/entity/live_list_entity.dart';

class AnchorChildCellWidget extends StatefulWidget {
  final LiveListModel model;

  const AnchorChildCellWidget({super.key, required this.model});

  @override
  State createState() => _AnchorChildCellWidgetState();
}

class _AnchorChildCellWidgetState extends State<AnchorChildCellWidget> {
  @override
  Widget build(BuildContext context) {
    LiveListModel model = widget.model;
    
    return Container(
      
    );
  }
}