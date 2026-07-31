import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/resource/values/app_colors.dart';

import 'start_view_controller.dart';

class StartView extends GetView<StartViewController> {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: null,
            child: Center(
              child: Obx((){
                return Text(controller.message.value);
              }),

            ),
          ),
          Positioned(
            bottom: 80,
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                '',
                // 'version: ${PackageInfoHelper().packageInfo.version}',
                textAlign: TextAlign.center,
                style: Get.textTheme.titleSmall,
              ),
            ),
          ),
          controller.buildLoadingIndicator(),
        ],
      ),
    );
  }
}
