import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final int? maxLength;
  final int? minLines;
  final Color? fillColor;       // 背景顏色
  final Color? enabledBorderColor; // 未選中時的邊框顏色
  final Color? focusedBorderColor; // 選中時的邊框顏色
  final double? borderWidth;    // 邊框寬度
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.maxLength = 255,
    this.minLines = 3,
    this.fillColor,
    this.enabledBorderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.borderWidth = 2.0,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength)
      ],
      style: const TextStyle(color: Colors.white),
      minLines: minLines,
      maxLines: null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: label == null ? null : const TextStyle(
            color: Colors.white
        ),
        hintText: hint,
        hintStyle: const TextStyle(
            color: Colors.white
        ),
        // 新增填充屬性
        filled: fillColor != null,
        fillColor: fillColor,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: label != null ? null :EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12.0
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: enabledBorderColor!, width: borderWidth!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: focusedBorderColor!),
        ),
      ),
    );
  }
}