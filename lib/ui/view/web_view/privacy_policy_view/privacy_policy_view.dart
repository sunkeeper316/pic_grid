import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/ui/view/web_view/privacy_policy_view/privacy_policy_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pic_grid/resource/values/app_colors.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyViewController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGary,
      appBar: AppBar(
        title: Text(S.of(context).settingPrivacyPolicyAndTerms),
        backgroundColor: AppColors.darkGary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        final webController = controller.webViewController.value;
        if (webController == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return WebViewWidget(controller: webController);
      }),
    );
  }
}
