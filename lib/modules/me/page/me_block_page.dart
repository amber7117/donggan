import 'package:flutter/material.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/manager/user_block_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_manager.dart';
import 'package:wzty/modules/me/widget/me_block_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';

class MeBlockPage extends StatefulWidget {
  const MeBlockPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MeBlockPageState();
  }
}

class _MeBlockPageState extends State {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<UserBlockEntity> _dataArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() async {
    List<UserBlockEntity> result =
        await UserBlockManger.instance.obtainBlockData();

    if (result.isNotEmpty) {
      _dataArr = result;
      _layoutState = LoadStatusType.success;
    } else {
      _layoutState = LoadStatusType.empty;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(titleText: "我的屏蔽"),
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            state: _layoutState, successWidget: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_layoutState != LoadStatusType.success) {
      return const SizedBox();
    }
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _dataArr.length,
        separatorBuilder: (context, index) {
          return const Divider(
              height: 0.5, color: ColorUtils.gray248, indent: 12);
        },
        itemBuilder: (context, index) {
          return MeBlockCellWidget(model: _dataArr[index]);
        });
  }
}
