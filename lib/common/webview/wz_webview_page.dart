import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wzty/main/lib/appbar.dart';

class WZWebviewPage extends StatefulWidget {
  final String title;
  final String urlStr;

  const WZWebviewPage(
      {super.key, required this.title, required this.urlStr});

  @override
  State createState() => _WZWebviewPageState();
}

class _WZWebviewPageState extends State<WZWebviewPage> {
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
          onProgress: (int progress) {},
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(titleText: widget.title),
        body: WebViewWidget(controller: controller));
  }
}
