import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wzty/modules/news/entity/news_detail_entity.dart';
import 'package:wzty/modules/news/widget/news_user_info_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class NewsDetailHeaderWidget extends StatefulWidget {
  final NewsDetilInfoModel model;

  const NewsDetailHeaderWidget({super.key, required this.model});

  @override
  State createState() => _NewsDetailHeaderWidgetState();
}

class _NewsDetailHeaderWidgetState extends State<NewsDetailHeaderWidget> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
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
    NewsDetilInfoModel model = widget.model;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
      child: Column(
        children: [
          Text(
            model.title,
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 26.sp,
                fontWeight: TextStyleUtils.medium),
          ),
          const SizedBox(height: 12),
          NewsUserInfoWidget(model: model),
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }

  String appendingHtmlStr(String htmlStr) {
    return "<html><head><style type=\"text/css\"> body {font-size:45px;color:#333333;margin:40px 30px;}</style> </head> <body><script type='text/javascript'>window.onload = () {var \$img = document.getElementsByTagName('img');for(var p in \$img){if(\$img[p].id == 'head_image')continue;\$img[p].style.width = '100%%';\$img[p].style.height ='auto';\$img[p].style.borderRadius ='16px';}};</script>$htmlStr</body></html>";
  }
}
