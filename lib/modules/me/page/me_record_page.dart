import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/modules/news/entity/news_list_entity.dart';
import 'package:wzty/modules/news/widget/news_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeRecordPage extends StatefulWidget {
  const MeRecordPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MeRecordPageState();
  }
}

class _MeRecordPageState extends State {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<NewsListModel> _dataArr = [];

  final EasyRefreshController _refreshCtrl = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _page = 1;

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    MeService.requestFootprintData(_page, (success, result) {
      ToastUtils.hideLoading();

      _handleResultData(success, result);
    });
  }

  _handleResultData(bool success, List<NewsListModel> result) {
    bool isMore = _page > 1;

    if (success) {
      if (result.isNotEmpty) {
        if (isMore) {
          _dataArr.addAll(result);
        } else {
          _dataArr = result;
        }

        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.empty;
      }
    } else {
      _layoutState = LoadStatusType.failure;
    }

    _refreshCtrl.finishRefresh();
    _refreshCtrl.finishLoad();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(titleText: "浏览记录"),
        backgroundColor: ColorUtils.gray248,
        body: LoadStateWidget(
            state: _layoutState, successWidget: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_dataArr.isEmpty) {
      return const SizedBox();
    }

    return EasyRefresh(
        controller: _refreshCtrl,
        onRefresh: () async {
          _page = 1;
          _requestData();
        },
        onLoad: () {
          _page++;
          _requestData();
        },
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _dataArr.length,
            itemExtent: newsChildCellHeight,
            itemBuilder: (context, index) {
              return NewsCellWidget(model: _dataArr[index]);
            }));
  }
}
