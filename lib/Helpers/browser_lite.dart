import 'package:flutter/material.dart';
import 'package:app_name/Colors_Text_Components/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserLite extends StatefulWidget {
  final String url;
  final String heading;
  const BrowserLite(this.url, this.heading, {super.key});

  @override
  State<BrowserLite> createState() => _BrowserLiteState();
}

class _BrowserLiteState extends State<BrowserLite> {
  @override
  Widget build(BuildContext context) {
    // var testurl = "https://www.btechtraders.com/'";
    // final Map<String, String> headers = {
    //   'User-Agent':
    //       'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'
    // };

    // String customUserAgent =
    //     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36';

    final controller = WebViewController()
      // ..enableZoom(true)
      // ..setUserAgent(customUserAgent)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            // print("Finished url is: " + url);
            print("URL Loadded in browserlite");
          },

          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(
        Uri.parse(
          widget.url.toString(),
          // testurl
        ),
        // headers: headers,
      );
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppbar(title: widget.heading.toString())),
      body: WebViewWidget(controller: controller),
    );
  }
}
