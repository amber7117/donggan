import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchHeadDateWidget extends StatefulWidget {
  final List<String> dateArr;
  final int selectIdx;
  final WZAnyCallback<int> callback;
  final VoidCallback calendarCb;

  const MatchHeadDateWidget(
      {super.key,
      required this.dateArr,
      required this.selectIdx,
      required this.callback,
      required this.calendarCb});

  @override
  State createState() => _MatchHeadDateWidgetState();
}

class _MatchHeadDateWidgetState extends State<MatchHeadDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10, left: 12, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.dateArr.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 6,
                    childAspectRatio: 52 / 33,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        widget.callback(index);
                      },
                      child: _buildCellWidget(index),
                    );
                  })),
          InkWell(
            onTap: () {
              widget.calendarCb();
            },
            child: const Padding(
                padding: EdgeInsets.all(12),
                child: JhAssetImage("match/iconCalendar", width: 24)),
          ),
        ],
      ),
    );
  }

  _buildCellWidget(int index) {
    String dateStr = widget.dateArr[index];
    String dateStr2 = "";
    if (dateStr.contains("\n")) {
      List<String> ret = dateStr.split("\n");
      dateStr = ret.first;
      dateStr2 = ret.last;
    }
    bool selected = widget.selectIdx == index;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: selected
              ? ColorUtils.red250
              : const Color.fromRGBO(250, 250, 250, 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dateStr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: selected
                    ? ColorUtils.red233
                    : const Color.fromRGBO(102, 102, 102, 1.0),
                fontSize: 12,
                fontWeight: TextStyleUtils.medium),
          ),
          dateStr2.isEmpty
              ? const SizedBox()
              : Text(
                  dateStr2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: selected
                          ? ColorUtils.red233
                          : const Color.fromRGBO(179, 179, 179, 1.0),
                      fontSize: 8,
                      fontWeight: TextStyleUtils.medium),
                ),
        ],
      ),
    );
  }
}
