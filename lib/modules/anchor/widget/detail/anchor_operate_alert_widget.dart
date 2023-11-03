import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class AnchorOperateAlertWidget extends StatelessWidget {
  const AnchorOperateAlertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 148.0) * 0.5;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: marginY),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("禁言",
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 16,
                      fontWeight: TextStyleUtils.regual)),
              Text("用户331991828",
                  style: TextStyle(
                      color: ColorUtils.red233,
                      fontSize: 16,
                      fontWeight: TextStyleUtils.regual)),
              Text("吗",
                  style: TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 16,
                      fontWeight: TextStyleUtils.regual)),
            ],
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 122,
                height: 40,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(250, 250, 250, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                    child: const Text('取消',
                        style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1.0),
                            fontSize: 16,
                            fontWeight: TextStyleUtils.regual)),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                width: 122,
                height: 40,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorUtils.red233,
                        ColorUtils.red217,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                    child: const Text('确认',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: TextStyleUtils.regual)),
                    onPressed: () {}),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
