import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class ChooseMenuWidget extends StatelessWidget {
  const ChooseMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double itemHeight = 40;
    double marginY = (popContentHeight() - 160.0) * 0.5;
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
            child: const Text("请选择动画类型",
                style: TextStyle(
                    color: ColorUtils.black51,
                    fontSize: 15,
                    fontWeight: TextStyleUtils.regual)),
          ),
          SizedBox(
            height: itemHeight,
            child: TextButton(
                onPressed: () {},
                child: const Text("平台视角",
                    style: TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 16,
                        fontWeight: TextStyleUtils.regual))),
          ),
          SizedBox(
            height: itemHeight,
            child: TextButton(
                onPressed: () {},
                child: const Text("看台视角",
                    style: TextStyle(
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
