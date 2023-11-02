import 'package:flutter/material.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/modules/anchor/entity/anchor_video_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const playbackCellHeight = 102.0;

class AnchorDetailPlaybackCellWidget extends StatefulWidget {
  final AnchorVideoModel model;
  final String nickName;

  const AnchorDetailPlaybackCellWidget(
      {super.key, required this.model, required this.nickName});

  @override
  State createState() => _AnchorDetailPlaybackCellWidgetState();
}

class _AnchorDetailPlaybackCellWidgetState
    extends State<AnchorDetailPlaybackCellWidget> {
  @override
  Widget build(BuildContext context) {
    AnchorVideoModel model = widget.model;
    return InkWell(
      onTap: () {
        Routes.push(context, Routes.livePlayback, arguments: model);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: buildNetImage(model.recordImg,
                        width: 124,
                        height: 70,
                        placeholder: "common/imgZhiboMoren")),
                Container(
                  width: 50,
                  height: 16,
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: Text(model.totalTimeNew,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: TextStyleUtils.medium)),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                SizedBox(
                  width: 150,
                  child: Text(model.liveTitle,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 12,
                          fontWeight: TextStyleUtils.semibold)),
                ),
                const SizedBox(height: 4),
                Text(model.startTime,
                    style: const TextStyle(
                        color: ColorUtils.gray179,
                        fontSize: 10,
                        fontWeight: TextStyleUtils.medium)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const JhAssetImage("anchor/iconView", width: 10),
                    const SizedBox(width: 4),
                    Text("${model.browseNum}",
                        style: const TextStyle(
                            color: ColorUtils.gray179,
                            fontSize: 10,
                            fontWeight: TextStyleUtils.medium)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
