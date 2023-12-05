import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWebsiteState();
}

class _MyWebsiteState extends State<HomeScreen> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        var isLastPage = await inAppWebViewController.canGoBack();

        if (isLastPage) {
          inAppWebViewController.goBack();
          isLastPage = true;
        } else {
          isLastPage = false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse("https://side-u.com")),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
              ),
              _progress < 1
                  ? LinearProgressIndicator(
                      value: _progress,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
