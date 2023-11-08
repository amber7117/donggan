import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class WZWebviewPage extends StatefulWidget {
  final String title;
  final String urlStr;

  const WZWebviewPage({super.key, required this.title, required this.urlStr});

  @override
  State createState() => _WZWebviewPageState();
}

class _WZWebviewPageState extends State<WZWebviewPage> {
  late WebViewController controller;
  LoadStatusType _layoutState = LoadStatusType.loading;

  @override
  void initState() {
    super.initState();

    if (widget.urlStr.isEmpty) {
      _layoutState = LoadStatusType.empty;
      return;
    }
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            ToastUtils.hideLoading();
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

    ToastUtils.showLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(titleText: widget.title),
      body: LoadStateWidget(
          state: _layoutState, successWidget: _buildChildWidget(context)),
    );
  }

  Widget _buildChildWidget(BuildContext context) {
    if (_layoutState != LoadStatusType.success) {
      return const SizedBox();
    }
    return WebViewWidget(controller: controller);
  }
}
