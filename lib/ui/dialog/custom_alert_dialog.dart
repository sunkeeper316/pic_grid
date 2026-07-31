import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/resource/values/app_colors.dart';

class CustomAlertDialog {
  static void show({
    required String title,
    required String content,
    required VoidCallback onPressed,
    Color? titleColor = Colors.white,
    Color? contentColor = Colors.white,
    Color? iconColor = Colors.red,
    Color? backgroundColor = AppColors.lightGary,
    Color? buttonCheckColor = AppColors.lightGary,
    Color? buttonCancelColor = AppColors.primaryColor,
    Widget? icon,
    bool showCancelButton = false,
    VoidCallback? onCancelPressed,
    bool showThirdButton = false,
    String? thirdButtonText,
    Color? thirdButtonColor,
    VoidCallback? onVipPressed,
    bool showFourthButton = false,
    String? fourthButtonText,
    Color? fourthButtonColor,
    VoidCallback? onFourthPressed,
  }) {
    final context = Get.context!;
    final defaultIcon = Icon(
      Icons.error,
      color: iconColor,
      size: 60,
    );
    final displayIcon = icon ?? defaultIcon;

    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: backgroundColor,
        icon: displayIcon,
        title: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: contentColor,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Column(
            children: [
              if (showThirdButton)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: thirdButtonColor ?? Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        thirdButtonText ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Get.back();
                        onVipPressed?.call();
                      },
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      side: BorderSide(
                        color: buttonCancelColor ?? Colors.white,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      S.of(context).ok,
                      style: TextStyle(color: buttonCancelColor),
                    ),
                    onPressed: () {
                      Get.back();
                      onPressed();
                    },
                  ),
                ),
              ),
              if (showFourthButton)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: fourthButtonColor ?? Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        fourthButtonText ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Get.back();
                        onFourthPressed?.call();
                      },
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12), // 分隔線空隙
          if (showCancelButton)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: buttonCancelColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    S.of(context).cancel,
                    style: TextStyle(color: buttonCheckColor),
                  ),
                  onPressed: () {
                    Get.back();
                    onCancelPressed?.call();
                  },
                ),
              ),
            ),
        ],

      ),
    );
  }
}

