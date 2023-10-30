import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';
import 'package:wzty/modules/match/widget/status/match_status_fb_live_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchStatusFBLivePage extends StatefulWidget {
  final List<MatchStatusFBLiveModel> liveModelArr;
  final List<MatchStatusFBEventModel> live2ModelArr;

  const MatchStatusFBLivePage(
      {super.key, required this.liveModelArr, required this.live2ModelArr});

  @override
  State createState() => _MatchStatusFBLivePageState();
}

class _MatchStatusFBLivePageState extends State<MatchStatusFBLivePage> {
  LoadStatusType _layoutState = LoadStatusType.success;

  @override
  Widget build(BuildContext context) {
    if (widget.liveModelArr.isEmpty && widget.live2ModelArr.isEmpty) {
      _layoutState = LoadStatusType.empty;
    }
    return LoadStateWidget(
        state: _layoutState, successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    List<MatchStatusFBLiveModel> liveModelArr = widget.liveModelArr;

    if (liveModelArr.isNotEmpty) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: liveModelArr.length,
          // itemExtent: statusLiveCellHeight,
          itemBuilder: (context, index) {
            MatchStatusFBLiveModel model = liveModelArr[index];
            if (model.typeId > 2000) {
              return _buildHintWidget(model.typeId, model.cnText);
            }
            return MatchStatusFBLiveCellWidget(liveModel: model);
          });
    } else {
      List<MatchStatusFBEventModel> live2ModelArr = widget.live2ModelArr;

      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: live2ModelArr.length,
          // itemExtent: statusLiveCellHeight,
          itemBuilder: (context, index) {
            MatchStatusFBEventModel model = live2ModelArr[index];
            if (model.typeId > 2000) {
              return _buildHintWidget(model.typeId, model.content);
            }
            return MatchStatusFBLiveCellWidget(live2Model: model);
          });
    }
  }

  _buildHintWidget(int typeId, String content) {
    Color hintColor = const Color.fromRGBO(102, 191, 102, 1);
    Color lineColor1 = ColorUtils.gray248;
    Color lineColor2 = ColorUtils.gray248;
    if (typeId == 2002 || typeId == 2003) {
      hintColor = ColorUtils.red233;
      lineColor1 = Colors.white;
    } else {
      lineColor2 = Colors.white;
    }

    return SizedBox(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.only(left: 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 41,
                alignment: Alignment.center,
                child: const SizedBox(width: 2, height: 17)
                    .colored(lineColor1),
              ),
              Container(
                width: 41,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hintColor,
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                ),
                child: Text(
                  content,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: TextStyleUtils.regual),
                ),
              ),
              Container(
                width: 41,
                alignment: Alignment.center,
                child: const SizedBox(width: 2, height: 17)
                    .colored(lineColor2),
              ),
            ],
          ),
        ));
  }
}
