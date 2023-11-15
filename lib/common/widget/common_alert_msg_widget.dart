import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class CommonAlertMsgWidget extends StatelessWidget {
  final String content;
  final VoidCallback callback;

  const CommonAlertMsgWidget(
      {super.key, required this.content, required this.callback});

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 148.0) * 0.5;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: marginY),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(content,
                  style: const TextStyle(
                      color: ColorUtils.black51,
                      fontSize: 16,
                      fontWeight: TextStyleUtils.regual))),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 122,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: ColorUtils.red233,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
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
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    child: const Text('确认',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: TextStyleUtils.regual)),
                    onPressed: () {
                      callback();
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
