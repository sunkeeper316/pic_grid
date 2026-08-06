// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(index) => "图层 ${index}";

  static String m1(error) => "保存失败：${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "albumPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "需要相册权限才能保存",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("PicGrid"),
    "borderColor": MessageLookupByLibrary.simpleMessage("颜色"),
    "borderNone": MessageLookupByLibrary.simpleMessage("无边框"),
    "borderSettings": MessageLookupByLibrary.simpleMessage("边框"),
    "borderThickness": MessageLookupByLibrary.simpleMessage("粗细"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "clipCancelTooltip": MessageLookupByLibrary.simpleMessage("取消"),
    "clipDoneTooltip": MessageLookupByLibrary.simpleMessage("完成"),
    "clipLoadingImage": MessageLookupByLibrary.simpleMessage("加载图片中..."),
    "clipResetTooltip": MessageLookupByLibrary.simpleMessage("重置裁剪范围"),
    "clipTitle": MessageLookupByLibrary.simpleMessage("裁剪图片"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "done": MessageLookupByLibrary.simpleMessage("完成"),
    "editorAddImageObjectTooltip": MessageLookupByLibrary.simpleMessage(
      "新增图片对象",
    ),
    "editorBackgroundSettingTooltip": MessageLookupByLibrary.simpleMessage(
      "背景设定",
    ),
    "editorBorderSettingsTooltip": MessageLookupByLibrary.simpleMessage("边框设置"),
    "editorCanvasBackgroundSetting": MessageLookupByLibrary.simpleMessage(
      "画布背景设定",
    ),
    "editorCropTooltip": MessageLookupByLibrary.simpleMessage("裁剪"),
    "editorDeleteTooltip": MessageLookupByLibrary.simpleMessage("删除"),
    "editorLayerListTooltip": MessageLookupByLibrary.simpleMessage("图层列表"),
    "editorOrPickSolidColor": MessageLookupByLibrary.simpleMessage("或选择单色背景："),
    "editorPickBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "从相册选择底图图片",
    ),
    "editorSaveToAlbumTooltip": MessageLookupByLibrary.simpleMessage("保存至相册"),
    "editorTitle": MessageLookupByLibrary.simpleMessage("编辑"),
    "error": MessageLookupByLibrary.simpleMessage("错误"),
    "homeBlankCanvas": MessageLookupByLibrary.simpleMessage("空白底图"),
    "homePickPhoto": MessageLookupByLibrary.simpleMessage("选择照片"),
    "homeSettingsTooltip": MessageLookupByLibrary.simpleMessage("设置"),
    "homeTagline": MessageLookupByLibrary.simpleMessage("开始选择照片来做拼贴或剪贴"),
    "imageSavedToAlbum": MessageLookupByLibrary.simpleMessage("图片已保存至相册"),
    "layerItem": m0,
    "layerListEmpty": MessageLookupByLibrary.simpleMessage("目前没有叠加对象"),
    "layerListTitle": MessageLookupByLibrary.simpleMessage("图层列表（拖动排序）"),
    "ok": MessageLookupByLibrary.simpleMessage("确定"),
    "permissionError": MessageLookupByLibrary.simpleMessage("权限错误"),
    "reset": MessageLookupByLibrary.simpleMessage("重置"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveFailed": m1,
    "settingContactUs": MessageLookupByLibrary.simpleMessage("联系我们"),
    "settingOneTimePurchaseForever": MessageLookupByLibrary.simpleMessage(
      "一次购买，永久去除",
    ),
    "settingPrivacyPolicyAndTerms": MessageLookupByLibrary.simpleMessage(
      "隐私政策与使用条款",
    ),
    "settingRemoveAds": MessageLookupByLibrary.simpleMessage("去除广告"),
    "settingSectionAbout": MessageLookupByLibrary.simpleMessage("关于"),
    "settingSectionPurchase": MessageLookupByLibrary.simpleMessage("购买"),
    "settingTitle": MessageLookupByLibrary.simpleMessage("设置"),
    "settingUnlocked": MessageLookupByLibrary.simpleMessage("已解锁"),
    "settingVersion": MessageLookupByLibrary.simpleMessage("版本"),
    "shapeCircle": MessageLookupByLibrary.simpleMessage("圆形"),
    "shapeHeart": MessageLookupByLibrary.simpleMessage("爱心"),
    "shapeRectangle": MessageLookupByLibrary.simpleMessage("矩形"),
    "shapeRoundedRectangle": MessageLookupByLibrary.simpleMessage("圆角"),
    "shapeStar": MessageLookupByLibrary.simpleMessage("星形"),
    "success": MessageLookupByLibrary.simpleMessage("成功"),
  };
}
