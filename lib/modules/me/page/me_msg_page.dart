import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wzty/common/widget/common_alert_msg_widget.dart';
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

  _requestMsgOperate(bool isDel) {
    String content = isDel ? "清空所有消息" : "全部标记为已读";
    showDialog(
        context: context,
        builder: (context) {
          return CommonAlertMsgWidget(
              content: content,
              callback: () {
                if (isDel) {
                  _requestMsgDeleteAll();
                } else {
                  _requestMsgRead();
                }
              });
        });
  }

  _requestMsgDelete(SysMsgModel model) {
    ToastUtils.showLoading();

    MeService.requestSysMsgDelete(model.id, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        ToastUtils.showSuccess("删除成功");

        _dataArr.removeWhere((element) => element.id == model.id);
        setState(() {});
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  _requestMsgDeleteAll() {
    ToastUtils.showLoading();

    MeService.requestSysMsgDeleteAll((success, result) {
      ToastUtils.hideLoading();
      if (success) {
        ToastUtils.showSuccess("清空所有成功");

        _dataArr.clear();
        setState(() {});
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  _requestMsgRead() {
    ToastUtils.showLoading();

    MeService.requestSysMsgRead((success, result) {
      ToastUtils.hideLoading();
      if (success) {
        ToastUtils.showSuccess("已读成功");

        for (var element in _dataArr) {
          element.type = 1;
        }
        setState(() {});
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarAndActions(titleText: "消息通知", actions: [
          InkWell(
              onTap: () {
                _requestMsgOperate(false);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: JhAssetImage("me/iconMsgRed", width: 24),
              )),
          InkWell(
              onTap: () {
                _requestMsgOperate(true);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      height: 0.5,
                      color: ColorUtils.gray248,
                      indent: 12,
                      thickness: 0.5);
                },
                itemBuilder: (context, index) {
                  SysMsgModel model = _dataArr[index];
                  return Slidable(
                    key: ValueKey(index),
                    endActionPane: ActionPane(
                      extentRatio: 0.15,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _requestMsgDelete(model);
                          },
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
      height: 76,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
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
                style: TextStyle(
                    color: model.type == 1
                        ? ColorUtils.gray153
                        : ColorUtils.black34,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              Text(
                model.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: model.type == 1
                        ? ColorUtils.gray153
                        : ColorUtils.black34,
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
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
