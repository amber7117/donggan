import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class ChooseMenuWidget extends StatelessWidget {
  final String title;
  final List<String> dataArr;
  final WZAnyCallback<int> callback;

  const ChooseMenuWidget(
      {super.key,
      required this.title,
      required this.dataArr,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    double itemHeight = 50;
    double marginY = (popContentHeight() - 200.0) * 0.5;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: marginY),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: itemHeight,
            alignment: Alignment.center,
            child: Text(title,
                style: const TextStyle(
                    color: ColorUtils.black51,
                    fontSize: 15,
                    fontWeight: TextStyleUtils.regual)),
          ),
          SizedBox(
            height: itemHeight,
            child: TextButton(
                onPressed: () {
                  callback(0);
                  Navigator.pop(context);
                },
                child: Text(dataArr.first,
                    style: const TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 16,
                        fontWeight: TextStyleUtils.regual))),
          ),
          SizedBox(
            height: itemHeight,
            child: TextButton(
                onPressed: () {
                  callback(1);
                  Navigator.pop(context);
                },
                child: Text(dataArr.last,
                    style: const TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 16,
                        fontWeight: TextStyleUtils.regual))),
          ),
          SizedBox(
            height: itemHeight,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(" 取消 ",
                    style: TextStyle(
                        color: ColorUtils.black51,
                        fontSize: 15,
                        fontWeight: TextStyleUtils.regual))),
          ),
        ],
      ),
    );
  }
}
