import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/resource/values/app_colors.dart';


class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    this.onTap,
    this.onHover,
    this.onLongPress,
    this.onFocusChange,
    required this.text,
    this.width,
    this.height = 50,
    this.icon,
    this.textColor,
    this.backgroundColor = AppColors.darkBlueGreen,
    this.textStyle,
    this.textSize = 14,
    this.sideColor,
  });

  /// 寬
  final double? width;

  /// 高
  final double height;

  /// 前綴圖示（可選）
  final IconData? icon;

  /// 文字
  final String text;

  /// 自訂style
  final TextStyle? textStyle;

  /// 文字顏色
  final Color? textColor;

  /// 文字大小
  final double textSize;

  /// 顏色
  final Color backgroundColor;

  final Color? sideColor;

  /// 點擊事件
  final GestureTapCallback? onTap;

  final ValueChanged<bool>? onHover;

  final VoidCallback? onLongPress;

  final ValueChanged<bool>? onFocusChange;

  @override
  State<PrimaryButton> createState() => PrimaryButtonState();
}

class PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width ?? double.infinity,
      child: ElevatedButton(
        //輪廓邊框 的button
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          backgroundColor: widget.backgroundColor,
          disabledBackgroundColor: AppColors.disabledGary,
        ),
        onPressed: widget.onTap,
        onHover: widget.onHover,
        onLongPress: widget.onLongPress,
        onFocusChange: widget.onFocusChange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: widget.textColor ?? Colors.white, size: 24),
              const SizedBox(width: 10),
            ],
            Text(
              widget.text,
              style: widget.textStyle ??
                  Get.textTheme.titleLarge?.copyWith(
                      color: widget.textColor ?? Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
