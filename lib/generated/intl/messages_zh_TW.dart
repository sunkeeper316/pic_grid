// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
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
  String get localeName => 'zh_TW';

  static String m0(index) => "圖層 ${index}";

  static String m1(error) => "儲存失敗：${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "ageRestrictionMessage": MessageLookupByLibrary.simpleMessage(
      "您必須年滿 18 歲才能使用此功能",
    ),
    "ageRestrictionTitle": MessageLookupByLibrary.simpleMessage("年齡限制"),
    "albumPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "需要相簿權限才能存檔",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("PicGrid"),
    "borderColor": MessageLookupByLibrary.simpleMessage("顏色"),
    "borderNone": MessageLookupByLibrary.simpleMessage("無框線"),
    "borderSettings": MessageLookupByLibrary.simpleMessage("框線"),
    "borderThickness": MessageLookupByLibrary.simpleMessage("粗細"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "clipCancelTooltip": MessageLookupByLibrary.simpleMessage("取消"),
    "clipDoneTooltip": MessageLookupByLibrary.simpleMessage("完成"),
    "clipLoadingImage": MessageLookupByLibrary.simpleMessage("載入圖片中..."),
    "clipResetTooltip": MessageLookupByLibrary.simpleMessage("重設裁切範圍"),
    "clipTitle": MessageLookupByLibrary.simpleMessage("裁剪圖片"),
    "delete": MessageLookupByLibrary.simpleMessage("刪除"),
    "done": MessageLookupByLibrary.simpleMessage("完成"),
    "editorAddImageObjectTooltip": MessageLookupByLibrary.simpleMessage(
      "新增圖片物件",
    ),
    "editorBackgroundSettingTooltip": MessageLookupByLibrary.simpleMessage(
      "背景設定",
    ),
    "editorBorderSettingsTooltip": MessageLookupByLibrary.simpleMessage("框線設定"),
    "editorCanvasBackgroundSetting": MessageLookupByLibrary.simpleMessage(
      "畫布背景設定",
    ),
    "editorCropTooltip": MessageLookupByLibrary.simpleMessage("裁剪"),
    "editorDeleteTooltip": MessageLookupByLibrary.simpleMessage("刪除"),
    "editorDiscardAndLeave": MessageLookupByLibrary.simpleMessage("放棄並返回"),
    "editorDiscardMessage": MessageLookupByLibrary.simpleMessage(
      "返回後目前的拼貼內容不會保留，需要重新編輯。",
    ),
    "editorDiscardTitle": MessageLookupByLibrary.simpleMessage("放棄目前的編輯？"),
    "editorKeepEditing": MessageLookupByLibrary.simpleMessage("繼續編輯"),
    "editorLayerListTooltip": MessageLookupByLibrary.simpleMessage("圖層列表"),
    "editorLayoutSettingsTooltip": MessageLookupByLibrary.simpleMessage("更換排版"),
    "editorOrPickSolidColor": MessageLookupByLibrary.simpleMessage("或選擇單色背景："),
    "editorPhotoSelectionRequired": MessageLookupByLibrary.simpleMessage(
      "請從首頁選擇 2～12 張照片。",
    ),
    "editorPickBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "從相片庫選擇底圖圖片",
    ),
    "editorReselectMessage": MessageLookupByLibrary.simpleMessage(
      "重新選擇後，目前的拼貼排版與編輯內容會被清除。",
    ),
    "editorReselectPhotos": MessageLookupByLibrary.simpleMessage("重新選擇"),
    "editorReselectTitle": MessageLookupByLibrary.simpleMessage("重新選擇照片？"),
    "editorSaveToAlbumTooltip": MessageLookupByLibrary.simpleMessage("儲存至相簿"),
    "editorTitle": MessageLookupByLibrary.simpleMessage("編輯"),
    "error": MessageLookupByLibrary.simpleMessage("錯誤"),
    "homeBlankCanvas": MessageLookupByLibrary.simpleMessage("空白底圖"),
    "homePickPhoto": MessageLookupByLibrary.simpleMessage("選擇照片"),
    "homeSettingsTooltip": MessageLookupByLibrary.simpleMessage("設定"),
    "homeTagline": MessageLookupByLibrary.simpleMessage("開始選擇照片來做拼貼或剪貼"),
    "imageProcessingFailed": MessageLookupByLibrary.simpleMessage("圖片處理失敗"),
    "imageSavedToAlbum": MessageLookupByLibrary.simpleMessage("圖片已儲存至相簿"),
    "layerItem": m0,
    "layerListEmpty": MessageLookupByLibrary.simpleMessage("目前沒有疊加物件"),
    "layerListTitle": MessageLookupByLibrary.simpleMessage("圖層列表（拖曳排序）"),
    "layoutMainBottom": MessageLookupByLibrary.simpleMessage("主圖置下"),
    "layoutMainLeft": MessageLookupByLibrary.simpleMessage("主圖置左"),
    "layoutMainRight": MessageLookupByLibrary.simpleMessage("主圖置右"),
    "layoutMainTop": MessageLookupByLibrary.simpleMessage("主圖置上"),
    "layoutSettings": MessageLookupByLibrary.simpleMessage("選擇排版"),
    "layoutTranspose": MessageLookupByLibrary.simpleMessage("切換網格方向"),
    "ok": MessageLookupByLibrary.simpleMessage("確定"),
    "permissionError": MessageLookupByLibrary.simpleMessage("權限錯誤"),
    "pickerAdd": MessageLookupByLibrary.simpleMessage("加入"),
    "pickerLoadFailed": MessageLookupByLibrary.simpleMessage("部分照片無法載入，請重新選擇。"),
    "pickerMinimumHint": MessageLookupByLibrary.simpleMessage("請選擇 2～12 張照片"),
    "pickerOpenSettings": MessageLookupByLibrary.simpleMessage("開啟設定"),
    "pickerTitle": MessageLookupByLibrary.simpleMessage("選擇照片"),
    "reset": MessageLookupByLibrary.simpleMessage("重設"),
    "save": MessageLookupByLibrary.simpleMessage("儲存"),
    "saveFailed": m1,
    "settingContactUs": MessageLookupByLibrary.simpleMessage("聯絡我們"),
    "settingOneTimePurchaseForever": MessageLookupByLibrary.simpleMessage(
      "一次購買，永久去除",
    ),
    "settingPrivacyPolicyAndTerms": MessageLookupByLibrary.simpleMessage(
      "隱私權政策與使用條款",
    ),
    "settingRemoveAds": MessageLookupByLibrary.simpleMessage("去除廣告"),
    "settingSectionAbout": MessageLookupByLibrary.simpleMessage("關於"),
    "settingSectionPurchase": MessageLookupByLibrary.simpleMessage("購買"),
    "settingTitle": MessageLookupByLibrary.simpleMessage("設定"),
    "settingUnlocked": MessageLookupByLibrary.simpleMessage("已解鎖"),
    "settingVersion": MessageLookupByLibrary.simpleMessage("版本"),
    "shapeCircle": MessageLookupByLibrary.simpleMessage("圓形"),
    "shapeHeart": MessageLookupByLibrary.simpleMessage("愛心"),
    "shapeRectangle": MessageLookupByLibrary.simpleMessage("矩形"),
    "shapeRoundedRectangle": MessageLookupByLibrary.simpleMessage("圓角"),
    "shapeStar": MessageLookupByLibrary.simpleMessage("星形"),
    "success": MessageLookupByLibrary.simpleMessage("成功"),
  };
}
