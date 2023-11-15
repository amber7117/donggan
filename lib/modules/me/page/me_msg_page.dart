import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/me/entity/sys_msg_entity.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeMsgPage extends StatefulWidget {
  const MeMsgPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MeMsgPageState();
  }
}

class _MeMsgPageState extends State {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<SysMsgModel> _dataArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    MeService.requestSysMsgList((success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result.isNotEmpty) {
          _dataArr = result;
          _layoutState = LoadStatusType.success;
        } else {
          _layoutState = LoadStatusType.empty;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarAndActions(titleText: "消息通知", actions: [
          InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: JhAssetImage("me/iconMsgRed", width: 24),
              )),
          InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: JhAssetImage("me/iconMsgDelete", width: 24),
              ))
        ]),
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            state: _layoutState,
            successWidget: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _dataArr.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                      height: 0.5, color: ColorUtils.gray248, indent: 12);
                },
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    endActionPane: const ActionPane(
                      extentRatio: 0.15,
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: doNothing,
                          backgroundColor: ColorUtils.red233,
                          foregroundColor: Colors.white,
                          label: '删\n除',
                        ),
                      ],
                    ),
                    child: _buildCellWidget(index),
                  );
                })));
  }

  _buildCellWidget(int idx) {
    SysMsgModel model = _dataArr[idx];
    return Container(
      height: 66,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 8),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: const TextStyle(
                    color: Color.fromRGBO(58, 58, 60, 1.0),
                    fontSize: 14,
                    fontWeight: TextStyleUtils.medium),
              ),
              Text(
                model.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: ColorUtils.gray149,
                    fontSize: 11,
                    fontWeight: TextStyleUtils.regual),
              ),
            ],
          )),
          const SizedBox(width: 40),
          Text(
            model.createdDateNew,
            style: const TextStyle(
                color: ColorUtils.gray149,
                fontSize: 11,
                fontWeight: TextStyleUtils.regual),
          ),
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {}
