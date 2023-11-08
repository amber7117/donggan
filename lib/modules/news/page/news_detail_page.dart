import 'package:flutter/material.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/report_sheet_widget.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/news/entity/news_comment_entity.dart';
import 'package:wzty/modules/news/entity/news_detail_entity.dart';
import 'package:wzty/modules/news/service/news_service.dart';
import 'package:wzty/modules/news/widget/news_cell_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_bottom_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_comment_cell_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_header_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_section_header_widget.dart';
import 'package:wzty/modules/news/widget/news_detail_text_widget.dart';
import 'package:wzty/utils/jh_image_utils.dart';
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

    _requestData(loading: true);
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

  _requestNewsComment() {
    String content = _textBarKey.currentState?.getText();

    if (content.isEmpty) {
      ToastUtils.showInfo("请输入有爱的评论");
      return;
    }

    NewsDetailInfoModel model = _model!.news!;
    ToastUtils.showLoading();

    NewsService.requestNewsComment(model.getNewsId(), content,
        (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        _textBarKey.currentState?.clearText();

        if (result != null) {
          model.commentCount += 1;
          _commentArr.insert(0, result);
        }

        Routes.unfocus();

        ToastUtils.showSuccess("评论成功");
      } else {
        ToastUtils.showError("评论失败");
      }
    });
  }

  _showReportUI() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          List<String> dataArr = [
            "色情低俗",
            "未成年相关",
            "违规营销",
            "不实信息",
            "违法违规",
            "政治敏感",
          ];
          return ReportSheetWidget(
              dataArr: dataArr,
              callback: (data) {
                ToastUtils.showLoading();
                Future.delayed(const Duration(seconds: 2), () {
                  ToastUtils.showSuccess("举报成功");
                });
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
            trailing: InkWell(
          onTap: () {
            _showReportUI();
          },
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: JhAssetImage("news/iconMore", width: 22)),
        )),
        backgroundColor: Colors.white,
        body: LoadStateWidget(
            state: _layoutState, successWidget: _buildChild(context)));
  }

  // -------------------------------------------

  _showTextBar() {
    if (!_textShowing) {
      _textShowing = true;
      _textBarKey.currentState?.textFocus();
    }
  }

  _hideTextBar() {
    if (_textShowing) {
      _textShowing = false;
    }
  }

  _handleTextBarEvent(NewsDetailTextEvent event) async {
    if (event == NewsDetailTextEvent.edit) {
    } else if (event == NewsDetailTextEvent.editEnd) {
      _hideTextBar();
    } else if (event == NewsDetailTextEvent.msgSend) {
      _requestNewsComment();
    }
  }

  bool _textShowing = false;
  final GlobalKey<NewsDetailTextWidgetState> _textBarKey = GlobalKey();

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
                    return NewsCellWidget(model: _model!.currentNews[index]);
                  }),
              const SliverToBoxAdapter(
                  child: NewsDetailSectionHeaderWidget(
                      type: NewsDetailSectionHeaderType.comment)),
              SliverList.builder(
                  itemCount: _commentArr.length,
                  itemBuilder: (context, index) {
                    return NewsDetailCommentCellWidget(
                        model: _commentArr[index]);
                  }),
              const SliverToBoxAdapter(
                child: SizedBox(height: newsDetailBottomHeight),
              ),
            ],
          ),
        ),
        Visibility(
          visible: !_textShowing,
          child: NewsDetailBottomWidget(
              model: _model!.news!,
              commentCb: () {
                _showTextBar();
              }),
        ),
        Offstage(
            offstage: !_textShowing,
            child: NewsDetailTextWidget(
                key: _textBarKey, callback: _handleTextBarEvent)),
      ],
    );
  }
}
