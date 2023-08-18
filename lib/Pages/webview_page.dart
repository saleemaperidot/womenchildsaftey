import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  WebViewPage({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: url,
      ),
    );
  }
}
