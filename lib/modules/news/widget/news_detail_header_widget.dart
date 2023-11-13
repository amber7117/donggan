import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wzty/modules/news/entity/news_detail_entity.dart';
import 'package:wzty/modules/news/widget/news_user_info_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class NewsDetailHeaderWidget extends StatefulWidget {
  final NewsDetailInfoModel model;

  const NewsDetailHeaderWidget({super.key, required this.model});

  @override
  State createState() => _NewsDetailHeaderWidgetState();
}

class _NewsDetailHeaderWidgetState extends State<NewsDetailHeaderWidget> {
  late WebViewController _controller;
  double _webviewHeight = ScreenUtil().screenHeight - 140;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            var height = await _controller
                .runJavaScriptReturningResult("document.body.offsetHeight");
            _webviewHeight = height as double;
            setState(() {});
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(appendingHtmlStr(widget.model.content));
  }

  @override
  Widget build(BuildContext context) {
    NewsDetailInfoModel model = widget.model;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
      child: Column(
        children: [
          Text(
            model.title,
            style: const TextStyle(
                color: ColorUtils.black34,
                fontSize: 26,
                fontWeight: TextStyleUtils.medium),
          ),
          const SizedBox(height: 12),
          NewsUserInfoWidget(model: model),
          const SizedBox(height: 10),
          SizedBox(
              width: double.infinity,
              height: _webviewHeight,
              child: WebViewWidget(controller: _controller)),
        ],
      ),
    );
  }

  String appendingHtmlStr(String htmlStr) {
    return "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'><style type='text/css'>body {font-size:18px;color:#333333;}#bottom-space {height: 1px;}</style></head><body><script type='text/javascript'>window.onload = () => {var imgArr = document.getElementsByTagName('img');for(var p in imgArr){imgArr[p].style.width = '100%';imgArr[p].style.height ='auto';imgArr[p].style.borderRadius ='8px';}};</script>$htmlStr<div id='bottom-space'></div></body></html>";
  }
}
