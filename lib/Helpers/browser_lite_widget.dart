import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserLite_Widget extends StatefulWidget {
  final String url;
  const BrowserLite_Widget(this.url, {super.key});

  @override
  State<BrowserLite_Widget> createState() => _BrowserLite_WidgetState();
}

class _BrowserLite_WidgetState extends State<BrowserLite_Widget> {
  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.parse(widget.url);
    // print(uri);
    if (!uri.hasScheme) {
      // If the URL doesn't have a scheme, add
      uri = Uri.parse("https://in.tradingview.com/");
    }

    final controller = WebViewController()
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            // print("Finishe url is: " + url);
            print("Widget Loaded");
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(uri);
    return WebViewWidget(controller: controller);
  }
}
