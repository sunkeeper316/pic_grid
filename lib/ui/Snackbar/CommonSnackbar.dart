

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackbar {
  static void show({
    required String message,
    String title = '',
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    IconData? icon,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(milliseconds: 800),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      duration: duration,
      icon: icon != null ? Icon(icon, color: textColor) : null,
    );
  }
}