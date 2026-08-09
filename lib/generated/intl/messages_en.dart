// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(index) => "Layer ${index}";

  static String m1(error) => "Save failed: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "ageRestrictionMessage": MessageLookupByLibrary.simpleMessage(
            "You must be at least 18 years old to use this feature"),
        "ageRestrictionTitle":
            MessageLookupByLibrary.simpleMessage("Age restriction"),
        "albumPermissionRequired": MessageLookupByLibrary.simpleMessage(
            "Album permission required to save"),
        "appTitle": MessageLookupByLibrary.simpleMessage("PicGrids"),
        "borderColor": MessageLookupByLibrary.simpleMessage("Color"),
        "borderNone": MessageLookupByLibrary.simpleMessage("None"),
        "borderSettings": MessageLookupByLibrary.simpleMessage("Border"),
        "borderThickness": MessageLookupByLibrary.simpleMessage("Thickness"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "clipCancelTooltip": MessageLookupByLibrary.simpleMessage("Cancel"),
        "clipDoneTooltip": MessageLookupByLibrary.simpleMessage("Done"),
        "clipLoadingImage":
            MessageLookupByLibrary.simpleMessage("Loading image..."),
        "clipResetTooltip":
            MessageLookupByLibrary.simpleMessage("Reset crop area"),
        "clipTitle": MessageLookupByLibrary.simpleMessage("Crop image"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "editorAddImageObjectTooltip":
            MessageLookupByLibrary.simpleMessage("Add image object"),
        "editorBackgroundSettingTooltip":
            MessageLookupByLibrary.simpleMessage("Background settings"),
        "editorBorderSettingsTooltip":
            MessageLookupByLibrary.simpleMessage("Border settings"),
        "editorCanvasBackgroundSetting":
            MessageLookupByLibrary.simpleMessage("Canvas background settings"),
        "editorCropTooltip": MessageLookupByLibrary.simpleMessage("Crop"),
        "editorDeleteTooltip": MessageLookupByLibrary.simpleMessage("Delete"),
        "editorDiscardAndLeave":
            MessageLookupByLibrary.simpleMessage("Discard and go back"),
        "editorDiscardMessage": MessageLookupByLibrary.simpleMessage(
            "Your current collage won\'t be saved after you go back, and you\'ll need to edit it again."),
        "editorDiscardTitle":
            MessageLookupByLibrary.simpleMessage("Discard your edits?"),
        "editorKeepEditing":
            MessageLookupByLibrary.simpleMessage("Keep editing"),
        "editorLayerListTooltip":
            MessageLookupByLibrary.simpleMessage("Layer list"),
        "editorLayoutSettingsTooltip":
            MessageLookupByLibrary.simpleMessage("Change layout"),
        "editorOrPickSolidColor":
            MessageLookupByLibrary.simpleMessage("Or pick a solid color:"),
        "editorPhotoSelectionRequired": MessageLookupByLibrary.simpleMessage(
            "Please select 2 to 12 photos from the home page."),
        "editorPickBackgroundImage":
            MessageLookupByLibrary.simpleMessage("Pick base image from album"),
        "editorReselectMessage": MessageLookupByLibrary.simpleMessage(
            "Selecting photos again will clear your current collage layout and edits."),
        "editorReselectPhotos":
            MessageLookupByLibrary.simpleMessage("Select again"),
        "editorReselectTitle":
            MessageLookupByLibrary.simpleMessage("Select photos again?"),
        "editorSaveToAlbumTooltip":
            MessageLookupByLibrary.simpleMessage("Save to album"),
        "editorTitle": MessageLookupByLibrary.simpleMessage("Edit"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "homeBlankCanvas": MessageLookupByLibrary.simpleMessage("Blank canvas"),
        "homePickPhoto": MessageLookupByLibrary.simpleMessage("Pick photo"),
        "homeSettingsTooltip": MessageLookupByLibrary.simpleMessage("Settings"),
        "homeTagline": MessageLookupByLibrary.simpleMessage(
            "Start selecting photos for collage or clipping"),
        "imageProcessingFailed":
            MessageLookupByLibrary.simpleMessage("Image processing failed"),
        "imageSavedToAlbum":
            MessageLookupByLibrary.simpleMessage("Image saved to album"),
        "layerItem": m0,
        "layerListEmpty":
            MessageLookupByLibrary.simpleMessage("No overlay items"),
        "layerListTitle": MessageLookupByLibrary.simpleMessage(
            "Layer list (drag to reorder)"),
        "layoutMainBottom": MessageLookupByLibrary.simpleMessage("Main bottom"),
        "layoutMainLeft": MessageLookupByLibrary.simpleMessage("Main left"),
        "layoutMainRight": MessageLookupByLibrary.simpleMessage("Main right"),
        "layoutMainTop": MessageLookupByLibrary.simpleMessage("Main top"),
        "layoutSettings": MessageLookupByLibrary.simpleMessage("Choose layout"),
        "layoutTranspose":
            MessageLookupByLibrary.simpleMessage("Switch grid direction"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "permissionError":
            MessageLookupByLibrary.simpleMessage("Permission error"),
        "pickerAdd": MessageLookupByLibrary.simpleMessage("Add"),
        "pickerLoadFailed": MessageLookupByLibrary.simpleMessage(
            "Some photos could not be loaded. Please try again."),
        "pickerMinimumHint":
            MessageLookupByLibrary.simpleMessage("Select 2 to 12 photos"),
        "pickerOpenSettings":
            MessageLookupByLibrary.simpleMessage("Open settings"),
        "pickerTitle": MessageLookupByLibrary.simpleMessage("Select photos"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveFailed": m1,
        "settingContactUs": MessageLookupByLibrary.simpleMessage("Contact us"),
        "settingOneTimePurchaseForever": MessageLookupByLibrary.simpleMessage(
            "One-time purchase, remove forever"),
        "settingPrivacyPolicyAndTerms":
            MessageLookupByLibrary.simpleMessage("Privacy Policy & Terms"),
        "settingRemoveAds": MessageLookupByLibrary.simpleMessage("Remove ads"),
        "settingSectionAbout": MessageLookupByLibrary.simpleMessage("About"),
        "settingSectionPurchase":
            MessageLookupByLibrary.simpleMessage("Purchase"),
        "settingTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingUnlocked": MessageLookupByLibrary.simpleMessage("Unlocked"),
        "settingVersion": MessageLookupByLibrary.simpleMessage("Version"),
        "shapeCircle": MessageLookupByLibrary.simpleMessage("Circle"),
        "shapeHeart": MessageLookupByLibrary.simpleMessage("Heart"),
        "shapeRectangle": MessageLookupByLibrary.simpleMessage("Rectangle"),
        "shapeRoundedRectangle":
            MessageLookupByLibrary.simpleMessage("Rounded"),
        "shapeStar": MessageLookupByLibrary.simpleMessage("Star"),
        "success": MessageLookupByLibrary.simpleMessage("Success")
      };
}
