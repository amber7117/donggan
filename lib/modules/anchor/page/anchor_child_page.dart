import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/anchor/entity/anchor_list_entity.dart';
import 'package:wzty/modules/anchor/service/anchor_service.dart';
import 'package:wzty/modules/anchor/widget/anchor_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class AnchorChildPage extends StatefulWidget {
  final LiveSportType type;

  const AnchorChildPage({super.key, required this.type});

  @override
  State createState() => _AnchorChildPageState();
}

class _AnchorChildPageState extends KeepAliveWidgetState<AnchorChildPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;

  List<AnchorListModel> _anchorArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    AnchorService.requestTypeList(widget.type, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result.isNotEmpty) {
          _anchorArr = result;

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
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    if (_anchorArr.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            children: [
              const Padding(
                  padding:
                      EdgeInsets.only(top: 12, bottom: 12, right: 5),
                  child: JhAssetImage("anchor/iconFire2", width: 16)),
              Text("${widget.type.title}直播",
                  style: const TextStyle(
                      color: ColorUtils.black34,
                      fontSize: 14,
                      fontWeight: TextStyleUtils.semibold)),
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: anchorCellRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 9,
              ),
              itemCount: _anchorArr.length,
              itemBuilder: (BuildContext context, int index) {
                return AnchorCellWidget(model: _anchorArr[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
