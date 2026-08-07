import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/resource/values/app_colors.dart';
import 'package:pic_grid/routes/routes.dart';
import 'package:pic_grid/ui/view/home/home_view_controller.dart';
import 'package:pic_grid/ui/weiget/primary_button.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            tooltip: S.of(context).homeSettingsTooltip,
            onPressed: () => Get.toNamed(Routes.settingView),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Logo
                  Center(
                    child: SvgPicture.asset(
                      'assets/Applogo.svg',
                      width: 120,
                      height: 120,
                      placeholderBuilder: (_) => const SizedBox(
                        width: 120,
                        height: 120,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // App 名稱
                  Text(
                    S.of(context).appTitle,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    S.of(context).pickerMinimumHint,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 36),
                  PrimaryButton(
                    text: S.current.homePickPhoto, // Grid Collage button
                    icon: Icons.grid_view_outlined,
                    height: 64,
                    onTap: controller.pickImages,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            child: Text(
              '',
              // 'version: ${PackageInfoHelper().packageInfo.version}',
              textAlign: TextAlign.center,
              style: Get.textTheme.titleSmall,
            ),
          ),
          controller.buildLoadingIndicator(),
        ],
      ),
    );
  }
}
