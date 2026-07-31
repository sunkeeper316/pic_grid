import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_picker_utils.dart';

class BirthdayUtils {
  /// 將日期時間字串轉換為純日期格式 (yyyy-MM-dd)
  static String formatToDateString(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return '';
    }
    try {
      final DateTime dateTime = DateTime.parse(dateTimeString);
      return dateTime.toString().split(' ')[0];
    } catch (e) {
      return '';
    }
  }

  /// 將 DateTime 轉換為純日期格式 (yyyy-MM-dd)
  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return dateTime.toString().split(' ')[0];
  }

  /// 獲取預設日期（20年前）
  static DateTime getDefaultDate() {
    final now = DateTime.now();
    return DateTime(now.year - 20, now.month, now.day);
  }

  /// 計算年齡
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// 計算年齡
  static int calculateAgeFromString(String birthDateStr) {
    try {
      // 將字串轉換為 DateTime
      final birthDate = DateTime.parse(birthDateStr);
      final now = DateTime.now();
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      // print('Error parsing date: $e');
      return 0; // 或者其他預設值
    }
  }

  /// 檢查是否達到最小年齡要求
  static bool isAgeValid(DateTime birthDate, {int minAge = 18}) {
    return calculateAge(birthDate) >= minAge;
  }

  /// 顯示生日選擇器
  static void showBirthdayPicker({
    required BuildContext context,
    required Function(DateTime) onDateSelected,
    required TextEditingController controller,
    required VoidCallback onValidate,
  }) {
    final initialDate = getDefaultDate();
    final minDate = DateTime(1900);
    final now = DateTime.now();
    final maxDate = DateTime(now.year - 18, now.month, now.day);

    DatePickerUtils.showDatePicker(
      context: context,
      initialDateTime: initialDate,
      minimumDate: minDate,
      maximumDate: maxDate,
      onDateSelected: (DateTime selectedDate) {
        if (!isAgeValid(selectedDate)) {
          // 顯示錯誤提示
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('年齡限制'),
              content: const Text('您必須年滿18歲才能使用此功能'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('確定'),
                ),
              ],
            ),
          );
          return;
        }

        // 更新文本框
        controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        onValidate();
        onDateSelected(selectedDate);
      },
      mode: CupertinoDatePickerMode.date,
      confirmButtonText: "完成",
    );
  }
}