import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';

class MatchDetailPage extends StatefulWidget {
  final int matchId;

  const MatchDetailPage(
      {super.key, required this.matchId});

  @override
  State<StatefulWidget> createState() {
    return _MatchDetailPageState();
  }
}

class _MatchDetailPageState extends State<MatchDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}