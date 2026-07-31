import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyViewController extends GetxController {
  final Rx<WebViewController?> webViewController = Rx<WebViewController?>(null);
  final String url = 'https://sunkeeper316.github.io/picclip_privacy_policy/';

  @override
  void onInit() {
    super.onInit();
    initWebViewController();
  }

  void initWebViewController() {
    webViewController.value = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }
}
