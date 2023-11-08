import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
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