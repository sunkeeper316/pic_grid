import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFormField<T> extends StatefulWidget {

  const CustomTextFormField({
    super.key,
    this.labelText ,
    this.labelStyle,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.controller,
    this.hintText,
    this.textColor,
    this.backgroundColor = Colors.transparent,
    this.textStyle ,
    this.textSize = 14,
    this.borderRadius = 15,
    this.borderSide,
    this.focusedBorderSide,
    this.contentPadding,
    this.prefixIconUrl,
    this.suffixIconUrl,
    this.suffixIcon,
    this.readOnly = false,
    this.enabled = true ,
    this.validator,
    this.validatorText,
    this.decoration,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
  });

  /// 文字
  final String? labelText;

  /// 文字
  final TextStyle? labelStyle;

  /// 文字
  final String? hintText;

  /// 自訂style
  final TextStyle? textStyle;

  /// 文字顏色
  final Color? textColor;

  /// 文字大小
  final double textSize;

  /// 顏色
  final Color backgroundColor;

  /// 點擊事件
  final GestureTapCallback? onTap;

  /// 編輯改變
  final ValueChanged<String>? onChanged;

  /// 編輯完畢
  final VoidCallback? onEditingComplete;

  /// 控制輸入
  final TextEditingController? controller;

  /// 前方icon
  final String? prefixIconUrl;

  /// 後方icon Widget
  final Widget? suffixIcon;

  /// 後方icon
  final String? suffixIconUrl;

  /// 圓角設定
  final double borderRadius;

  /// 邊角設定
  final BorderSide? borderSide;

  /// 編輯時邊角設定
  final BorderSide? focusedBorderSide;

  /// 內容邊框
  final EdgeInsetsGeometry? contentPadding;

  /// 只能讀取
  final bool readOnly ;

  /// 只能讀取
  final bool enabled;

  /// 驗證
  final FormFieldValidator<String>? validator;

  final String? validatorText;

  /// 輸入邊框
  final InputDecoration? decoration;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final int? maxLength;

  @override
  State<CustomTextFormField> createState() => Custom1TextFieldState();

}

class Custom1TextFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      readOnly:widget.readOnly,
      keyboardType: widget.keyboardType,
      style: widget.textStyle ?? TextStyle(fontSize: 16, color: Colors.white),
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      validator: widget.validator ?? ((value) => value == null || value.trim().isEmpty ? widget.validatorText : null) ,
      maxLength: widget.maxLength,
      decoration: widget.decoration ?? InputDecoration(
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ?? TextStyle(color: Colors.white),
        hintText: widget.hintText,
        // hintStyle: TextStyle(color: widget.hintColor ?? Colors.white),
        filled: true,
        fillColor: widget.backgroundColor,
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(15.0),
        prefixIcon: widget.prefixIconUrl == null ? null : Container(padding: EdgeInsets.all(5),child: SvgPicture.asset(widget.prefixIconUrl ?? '' , fit: BoxFit.scaleDown,),),
        prefixIconConstraints: BoxConstraints(maxWidth: 40 , maxHeight: 40),
        suffixIcon: widget.suffixIcon ?? (widget.suffixIconUrl == null ? null : SvgPicture.asset(widget.suffixIconUrl ?? '' , fit: BoxFit.scaleDown,)),
        suffixIconConstraints: BoxConstraints(maxWidth: 40 , maxHeight: 40),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderRadius:  BorderRadius.circular(widget.borderRadius),
          borderSide:  const BorderSide(color: Colors.red, width: 1),
        ),
        errorBorder:OutlineInputBorder(
          borderRadius:  BorderRadius.circular(widget.borderRadius),
          borderSide:  const BorderSide(color: Colors.red, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius:  BorderRadius.circular(widget.borderRadius),
          borderSide:  const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
    );
  }

}