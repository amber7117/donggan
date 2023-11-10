import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wzty/common/extension/extension_widget.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/me/entity/problem_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class AppProblemPage extends StatefulWidget {
  const AppProblemPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppProblemPageState();
  }
}

class _AppProblemPageState extends State {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<ProblemEntity> _dataArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() async {
    String fileText = await rootBundle.loadString('assets/json/question.json');

    Map<String, dynamic> data = jsonDecode(fileText);
    List tmpList = data["data"];
    List<ProblemEntity> retList =
        tmpList.map((dataMap) => ProblemEntity.fromJson(dataMap)).toList();

    _dataArr = retList;
    _layoutState = LoadStatusType.success;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(titleText: "常见问题"),
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            state: _layoutState, successWidget: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_layoutState != LoadStatusType.success) {
      return const SizedBox();
    }
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _dataArr.length,
        itemBuilder: (context, index) {
          ProblemEntity model = _dataArr[index];
          if (model.showAll) {
            return Column(
              children: [
                _buildTitleWidget(model.question, model),
                ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: model.answerList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index2) {
                      return _buildCellWidget(model.answerList[index2]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                          height: 0.5, color: ColorUtils.gray216, indent: 12);
                    }),
                const SizedBox(width: double.infinity, height: 20)
                    .colored(ColorUtils.gray248),
              ],
            );
          } else {
            return Column(
              children: [
                _buildTitleWidget(model.question, model),
                const SizedBox(),
                const SizedBox(width: double.infinity, height: 20)
                    .colored(ColorUtils.gray248),
              ],
            );
          }
        });
  }

  _buildTitleWidget(String title, ProblemEntity problemEntity) {
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 14,
                    fontWeight: TextStyleUtils.regual)),
          ),
          InkWell(
            onTap: () {
              problemEntity.showAll = !problemEntity.showAll;
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: problemEntity.showAll
                  ? const JhAssetImage("me/icon_arrow_up", width: 16)
                  : const JhAssetImage("me/icon_arrow_down", width: 16),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  _buildCellWidget(AnswerList model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text("问：${model.ask}",
              style: const TextStyle(
                  color: ColorUtils.gray149,
                  fontSize: 13,
                  fontWeight: TextStyleUtils.regual)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text("答：${model.answer}",
              style: const TextStyle(
                  color: ColorUtils.gray149,
                  fontSize: 13,
                  fontWeight: TextStyleUtils.regual)),
        ),
      ],
    );
  }
}
