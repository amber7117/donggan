import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wzty/main/lib/load_state_widget.dart';

class WZWebviewWidget extends StatefulWidget {
  final String urlStr;

  const WZWebviewWidget({super.key, required this.urlStr});

  @override
  State createState() => _WZWebviewWidgetState();
}

class _WZWebviewWidgetState extends State<WZWebviewWidget> {
  late WebViewController controller;
  LoadStatusType _layoutState = LoadStatusType.loading;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            _layoutState = LoadStatusType.success;
            setState(() {});
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
    return LoadStateWidget(
        state: _layoutState,
        needLoading: true,
        successWidget: _buildChildWidget(context));
  }

  Widget _buildChildWidget(BuildContext context) {
    if (_layoutState != LoadStatusType.success) {
      return const SizedBox();
    } else {
      return WebViewWidget(controller: controller);
    }
  }
}
