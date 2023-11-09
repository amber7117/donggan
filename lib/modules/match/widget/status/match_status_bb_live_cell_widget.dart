import 'package:flutter/material.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_event_entity.dart';
import 'package:wzty/modules/match/entity/detail/match_status_fb_live_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double statusBBLiveCellHeight = 79.0;

class MatchStatusBbLiveCellWidget extends StatelessWidget {
  final MatchStatusFBLiveModel? liveModel;
  final MatchStatusFBEventModel? live2Model;

  const MatchStatusBbLiveCellWidget(
      {super.key, this.liveModel, this.live2Model});

  @override
  Widget build(BuildContext context) {
    String time;
    int team;
    String content;
    String score;
    if (liveModel != null) {
      time = "${liveModel!.time}'";
      team = liveModel!.team;
      content = liveModel!.cnText;
      score = "${liveModel!.hostScore}-${liveModel!.guestScore}";
    } else {
      int minute = live2Model!.occurTime ~/ 60;
      int second = live2Model!.occurTime - minute * 60;

      time =
          "${live2Model!.statusName} ${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}";
      team = live2Model!.team;
      content = live2Model!.content;
      score = live2Model!.scores;
    }
    Color lineColor;
    if (team == 1) {
      lineColor = ColorUtils.red233;
    } else if (team == 2) {
      lineColor = ColorUtils.blue66;
    } else {
      lineColor = ColorUtils.gray248;
    }
    //72-24
    return SizedBox(
      height: statusBBLiveCellHeight,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Column(
            children: [
              const SizedBox(width: 2, height: 24).colored(ColorUtils.gray248),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                    color: ColorUtils.gray248,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
              ),
              const SizedBox(width: 2, height: 24).colored(ColorUtils.gray248),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: ColorUtils.gray153,
                            fontSize: 12,
                            fontWeight: TextStyleUtils.regual),
                      ),
                      Text(
                        score,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: ColorUtils.gray153,
                            fontSize: 12,
                            fontWeight: TextStyleUtils.regual),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 49,
                  decoration: BoxDecoration(
                      color: ColorUtils.gray248,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      border: Border.all(
                          width: 0.5,
                          color: const Color.fromRGBO(238, 238, 238, 1.0))),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          content,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: ColorUtils.gray153,
                              fontSize: 12,
                              fontWeight: TextStyleUtils.regual),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                          width: 3,
                          height: 60,
                          decoration: BoxDecoration(
                              color: lineColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(3),
                                  bottomRight: Radius.circular(3)))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
