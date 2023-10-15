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
import 'package:wzty/modules/news/widget/news_detail_header_widget.dart';
import 'package:wzty/utils/color_utils.dart';
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

  late WebViewController controller;
  double webviewHeight = ScreenUtil().screenHeight;

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

        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {},
              onPageStarted: (String url) {},
              onPageFinished: (String url) async {
                var height = await controller
                    .runJavaScriptReturningResult("document.body.offsetHeight");
                webviewHeight = height.toString().toDouble();
                setState(() {});
              },
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadHtmlString(appendingHtmlStr(_model!.news!.content));
      } else {
        _layoutState = LoadStatusType.failure;
      }

      setState(() {});
    });
  }

  String appendingHtmlStr(String htmlStr) {
    return "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'><style type='text/css'>body {font-size:36px;color:#333333;margin:10px 10px;}</style></head><body><script type='text/javascript'>window.onload = () => {var imgArr = document.getElementsByTagName('img');for(var p in imgArr){imgArr[p].style.width = '100%';imgArr[p].style.height ='auto';imgArr[p].style.borderRadius ='16px';}};</script>$htmlStr</body></html>";
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

    // return ListView.builder(
    //   shrinkWrap: true,
    //         padding: EdgeInsets.zero,
    //         itemCount: _model!.currentNews.length,
    //         // itemExtent: 300,
    //         itemBuilder: (context, index) {
    //           if (index == 0) {
    //             return WebViewWidget(controller: controller);
    //           }
    //           return NewsChildCellWidget(model: _model!.currentNews[index]);
    //         });

    return CustomScrollView(
      slivers: [
        // SliverToBoxAdapter(
        //   child: NewsDetailHeaderWidget(model: _model!.news!),
        // ),
        SliverToBoxAdapter(
          child: SizedBox(
              width: double.infinity,
              height: webviewHeight,
              child: WebViewWidget(controller: controller)),
        ),
        SliverList.builder(
            itemCount: _model!.currentNews.length,
            itemBuilder: (context, index) {
              return NewsChildCellWidget(model: _model!.currentNews[index]);
            }),
        // SliverFixedExtentList.builder(
        //     itemCount: _model!.currentNews.length,
        //     itemExtent: newsChildCellHeight,
        //     itemBuilder: (context, index) {
        //       if (index == 0) {
        //         return WebViewWidget(controller: controller);
        //       }
        //       return NewsChildCellWidget(model: _model!.currentNews[index]);
        //     }),
      ],
    );
  }
}
