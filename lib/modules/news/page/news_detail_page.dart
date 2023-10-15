import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wzty/common/extension/extension_app.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/news/entity/news_comment_entity.dart';
import 'package:wzty/modules/news/entity/news_detail_entity.dart';
import 'package:wzty/modules/news/service/news_service.dart';
import 'package:wzty/modules/news/widget/news_child_cell_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_bottom_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_comment_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_header_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_section_header_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class NewsDetailPage extends StatefulWidget {
  final String newsId;

  const NewsDetailPage({super.key, required this.newsId});

  @override
  State createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  NewsDetailModel? _model;
  List<NewsCommentModel> _commentArr = [];

  int _page = 1;

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData({bool loading = false}) async {
    if (loading) ToastUtils.showLoading();

    Future detail = NewsService.requestDetail(widget.newsId, (success, result) {
      _model = result;
    });

    Future comment = NewsService.requestDetailComment(widget.newsId, _page,
        (success, result) {
      _commentArr = result;
    });

    Future.wait([detail, comment]).then((value) {
      ToastUtils.hideLoading();

      if (_model != null) {
        _layoutState = LoadStatusType.success;
      } else {
        _layoutState = LoadStatusType.failure;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context),
        backgroundColor: Colors.white,
        body: LoadStateWidget(
            state: _layoutState, successWidget: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_model == null) {
      return const SizedBox();
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: NewsDetailHeaderWidget(model: _model!.news!),
              ),
              const SliverToBoxAdapter(
                  child: NewsDetailSectionHeaderWidget(
                      type: NewsDetailSectionHeaderType.news)),
              SliverFixedExtentList.builder(
                  itemCount: _model!.currentNews.length,
                  itemExtent: newsChildCellHeight,
                  itemBuilder: (context, index) {
                    return NewsChildCellWidget(
                        model: _model!.currentNews[index]);
                  }),
              const SliverToBoxAdapter(
                  child: NewsDetailSectionHeaderWidget(
                      type: NewsDetailSectionHeaderType.comment)),
              SliverList.builder(
                  itemCount: _commentArr.length,
                  itemBuilder: (context, index) {
                    return NewsDetailCommentWidget(model: _commentArr[index]);
                  }),
              const SliverToBoxAdapter(
                child: SizedBox(height: 56),
              ),
            ],
          ),
        ),
        const NewsDetailBottomWidget(),
      ],
    );
  }
}
