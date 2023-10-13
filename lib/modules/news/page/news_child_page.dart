import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/news/entity/news_list_entity.dart';
import 'package:wzty/modules/news/service/news_service.dart';
import 'package:wzty/modules/news/widget/news_child_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class NewsChildPage extends StatefulWidget {
  final int categoryId;

  const NewsChildPage({super.key, required this.categoryId});

  @override
  State<StatefulWidget> createState() {
    return _NewsChildPageState();
  }
}

class _NewsChildPageState extends KeepAliveLifeWidgetState<NewsChildPage> {
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

  _requestData({bool loading = false}) {
    if (loading) ToastUtils.showLoading();

    if (widget.categoryId > 0) {
      NewsService.requestTypeList(widget.categoryId, _page, (success, result) {
        ToastUtils.hideLoading();

        _handleResultData(success, result);
      });
    } else {
      NewsService.requestHotList(_page, (success, result) {
        ToastUtils.hideLoading();

        _handleResultData(success, result);
      });
    }
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
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
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
              return NewsChildCellWidget(model: _dataArr[index]);
            }));
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }
}
