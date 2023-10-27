import 'package:flutter/material.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';

const double statusLiveCellHeight = 50.0;

class MatchStatusLiveCellWidget extends StatefulWidget {
  final MatchStatusFBLiveModel? liveModel;
  final MatchStatusFBEventModel? live2Model;
  
  const MatchStatusLiveCellWidget({super.key, this.liveModel, this.live2Model});

  @override
  State createState() => _MatchStatusLiveCellWidgetState();
}

class _MatchStatusLiveCellWidgetState extends State<MatchStatusLiveCellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [],
          ),
          Row(
            children: [

            ],
          )
        ],
      ),
    );
  }
}
