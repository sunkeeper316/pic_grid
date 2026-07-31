import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/resource/values/app_colors.dart';
import 'package:pic_grid/ui/view/setting/setting_view_controller.dart';
import 'package:pic_grid/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends GetView<SettingViewController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGary,
      appBar: AppBar(
        title: Text(S.of(context).settingTitle),
        backgroundColor: AppColors.darkGary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            // _sectionTitle(S.of(context).settingSectionPurchase),
            // Obx(() => _tile(
            //       icon: Icons.block,
            //       title: S.of(context).settingRemoveAds,
            //       subtitle: controller.isAdRemoved.value ? S.of(context).settingUnlocked : S.of(context).settingOneTimePurchaseForever,
            //       trailing: controller.isAdRemoved.value
            //           ? const Icon(Icons.check_circle, color: Colors.greenAccent)
            //           : const Icon(Icons.chevron_right, color: Colors.white38),
            //       onTap: controller.isAdRemoved.value
            //           ? null
            //           : () {
            //               // TODO: 接 in_app_purchase 開啟購買流程
            //             },
            //     )),
            // const Divider(color: Colors.white12, height: 32),
            _sectionTitle(S.of(context).settingSectionAbout),
            Obx(() => _tile(
                  icon: Icons.info_outline,
                  title: S.of(context).settingVersion,
                  subtitle: controller.appVersion.value,
                )),
            _tile(
              icon: Icons.mail_outline,
              title: S.of(context).settingContactUs,
              onTap: () async {
                final Uri url = Uri.parse('https://sunkeeper316.github.io/sunkeeper_studio_website/');
                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                  debugPrint('Could not launch $url');
                }
              },
            ),
            _tile(
              icon: Icons.privacy_tip_outlined,
              title: S.of(context).settingPrivacyPolicyAndTerms,
              onTap: () {
                Get.toNamed(Routes.privacyPolicyView);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );

  Widget _tile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle, style: const TextStyle(color: Colors.white54)),
      trailing: trailing ??
          (onTap == null
              ? null
              : const Icon(Icons.chevron_right, color: Colors.white38)),
      onTap: onTap,
    );
  }
}
