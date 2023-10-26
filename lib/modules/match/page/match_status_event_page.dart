import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';

class MatchStatusEventPage extends StatefulWidget {

  final List<MatchStatusFBEventModel> eventModelArr;
  
  const MatchStatusEventPage({super.key, required this.eventModelArr});

  @override
  State createState() => _MatchStatusEventPageState();
}

class _MatchStatusEventPageState extends State<MatchStatusEventPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
