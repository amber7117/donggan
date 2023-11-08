import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/utils/toast_utils.dart';

class WZWebviewLocalPage extends StatefulWidget {
  final String title;
  final String htmlName;

  const WZWebviewLocalPage(
      {super.key, required this.title, required this.htmlName});

  @override
  State createState() => _WZWebviewLocalPageState();
}

class _WZWebviewLocalPageState extends State<WZWebviewLocalPage> {
  late WebViewController controller;

  String _htmlContent = '';

  @override
  void initState() {
    super.initState();

    _loadHtmlFromAssets();
  }

  _loadHtmlFromAssets() async {
    ToastUtils.showLoading();

    String fileText =
        await rootBundle.loadString('assets/html/${widget.htmlName}');
    _htmlContent = fileText;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
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
      ..loadHtmlString(_htmlContent);

    ToastUtils.hideLoading();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(titleText: widget.title),
        body: _buildChildWidget(context));
  }

  Widget _buildChildWidget(BuildContext context) {
    if (_htmlContent.isEmpty) {
      return const SizedBox();
    }
    return WebViewWidget(controller: controller);
  }
}
