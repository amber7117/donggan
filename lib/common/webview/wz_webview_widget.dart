import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wzty/utils/toast_utils.dart';

class WZWebviewWidget extends StatefulWidget {

  final String urlStr;

  const WZWebviewWidget({super.key, required this.urlStr});

  @override
  State createState() => _WZWebviewWidgetState();
}

class _WZWebviewWidgetState extends State<WZWebviewWidget> {

  late WebViewController controller;
  
  @override
  void initState() {
    super.initState();
    
    ToastUtils.showLoading();
    
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            ToastUtils.hideLoading();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.urlStr));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}