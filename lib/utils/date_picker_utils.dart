import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerUtils {
  /// 顯示 Cupertino 日期選擇器（暗色系）
  static void showDatePicker({
    required BuildContext context,
    required DateTime initialDateTime,
    required void Function(DateTime) onDateSelected,
    required DateTime minimumDate,
    required DateTime maximumDate,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
    Color backgroundColor = Colors.black, // 背景默認為黑色
    String confirmButtonText = "確定",
    TextStyle confirmButtonStyle = const TextStyle(color: Colors.white), // 確認按鈕文字顏色
    TextStyle datePickerTextStyle = const TextStyle(color: Colors.white, fontSize: 18),  // 日期選擇器文字樣式
  }) {
    DateTime selectedDate = initialDateTime;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          color: backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: SizedBox.shrink()),
                  TextButton(
                    onPressed: () {
                      onDateSelected(selectedDate); // 確認時回傳日期
                      Navigator.pop(builder); // 關閉選擇器
                    },
                    child: Text(
                      confirmButtonText,
                      style: confirmButtonStyle, // 設置確認按鈕樣式
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 200,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: Brightness.dark, // 設置為暗色主題
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: datePickerTextStyle, // 日期選擇器文字樣式
                    ),
                  ),
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.transparent,
                    initialDateTime: initialDateTime,
                    use24hFormat: true,
                    mode: mode, // 默認模式為日期
                    minimumDate: minimumDate,
                    maximumDate: maximumDate,
                    onDateTimeChanged: (DateTime value) {
                      selectedDate = value; // 更新選擇的日期
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
