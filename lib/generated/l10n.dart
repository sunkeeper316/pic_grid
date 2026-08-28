// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PicGrids`
  String get appTitle {
    return Intl.message(
      'PicGrids',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Start selecting photos for collage or clipping`
  String get homeTagline {
    return Intl.message(
      'Start selecting photos for collage or clipping',
      name: 'homeTagline',
      desc: '',
      args: [],
    );
  }

  /// `Blank canvas`
  String get homeBlankCanvas {
    return Intl.message(
      'Blank canvas',
      name: 'homeBlankCanvas',
      desc: '',
      args: [],
    );
  }

  /// `Pick photo`
  String get homePickPhoto {
    return Intl.message(
      'Pick photo',
      name: 'homePickPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get homeSettingsTooltip {
    return Intl.message(
      'Settings',
      name: 'homeSettingsTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Select photos`
  String get pickerTitle {
    return Intl.message(
      'Select photos',
      name: 'pickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get pickerAdd {
    return Intl.message(
      'Add',
      name: 'pickerAdd',
      desc: '',
      args: [],
    );
  }

  /// `Select 2 to 12 photos`
  String get pickerMinimumHint {
    return Intl.message(
      'Select 2 to 12 photos',
      name: 'pickerMinimumHint',
      desc: '',
      args: [],
    );
  }

  /// `Open settings`
  String get pickerOpenSettings {
    return Intl.message(
      'Open settings',
      name: 'pickerOpenSettings',
      desc: '',
      args: [],
    );
  }

  /// `Some photos could not be loaded. Please try again.`
  String get pickerLoadFailed {
    return Intl.message(
      'Some photos could not be loaded. Please try again.',
      name: 'pickerLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editorTitle {
    return Intl.message(
      'Edit',
      name: 'editorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Crop`
  String get editorCropTooltip {
    return Intl.message(
      'Crop',
      name: 'editorCropTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get editorDeleteTooltip {
    return Intl.message(
      'Delete',
      name: 'editorDeleteTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Background settings`
  String get editorBackgroundSettingTooltip {
    return Intl.message(
      'Background settings',
      name: 'editorBackgroundSettingTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Add image object`
  String get editorAddImageObjectTooltip {
    return Intl.message(
      'Add image object',
      name: 'editorAddImageObjectTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Layer list`
  String get editorLayerListTooltip {
    return Intl.message(
      'Layer list',
      name: 'editorLayerListTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Save to album`
  String get editorSaveToAlbumTooltip {
    return Intl.message(
      'Save to album',
      name: 'editorSaveToAlbumTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Border settings`
  String get editorBorderSettingsTooltip {
    return Intl.message(
      'Border settings',
      name: 'editorBorderSettingsTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Change layout`
  String get editorLayoutSettingsTooltip {
    return Intl.message(
      'Change layout',
      name: 'editorLayoutSettingsTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Choose layout`
  String get layoutSettings {
    return Intl.message(
      'Choose layout',
      name: 'layoutSettings',
      desc: '',
      args: [],
    );
  }

  /// `Main left`
  String get layoutMainLeft {
    return Intl.message(
      'Main left',
      name: 'layoutMainLeft',
      desc: '',
      args: [],
    );
  }

  /// `Main right`
  String get layoutMainRight {
    return Intl.message(
      'Main right',
      name: 'layoutMainRight',
      desc: '',
      args: [],
    );
  }

  /// `Main top`
  String get layoutMainTop {
    return Intl.message(
      'Main top',
      name: 'layoutMainTop',
      desc: '',
      args: [],
    );
  }

  /// `Main bottom`
  String get layoutMainBottom {
    return Intl.message(
      'Main bottom',
      name: 'layoutMainBottom',
      desc: '',
      args: [],
    );
  }

  /// `Switch grid direction`
  String get layoutTranspose {
    return Intl.message(
      'Switch grid direction',
      name: 'layoutTranspose',
      desc: '',
      args: [],
    );
  }

  /// `Border`
  String get borderSettings {
    return Intl.message(
      'Border',
      name: 'borderSettings',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get borderColor {
    return Intl.message(
      'Color',
      name: 'borderColor',
      desc: '',
      args: [],
    );
  }

  /// `Thickness`
  String get borderThickness {
    return Intl.message(
      'Thickness',
      name: 'borderThickness',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get borderNone {
    return Intl.message(
      'None',
      name: 'borderNone',
      desc: '',
      args: [],
    );
  }

  /// `Canvas background settings`
  String get editorCanvasBackgroundSetting {
    return Intl.message(
      'Canvas background settings',
      name: 'editorCanvasBackgroundSetting',
      desc: '',
      args: [],
    );
  }

  /// `Pick base image from album`
  String get editorPickBackgroundImage {
    return Intl.message(
      'Pick base image from album',
      name: 'editorPickBackgroundImage',
      desc: '',
      args: [],
    );
  }

  /// `Or pick a solid color:`
  String get editorOrPickSolidColor {
    return Intl.message(
      'Or pick a solid color:',
      name: 'editorOrPickSolidColor',
      desc: '',
      args: [],
    );
  }

  /// `Please select 2 to 12 photos from the home page.`
  String get editorPhotoSelectionRequired {
    return Intl.message(
      'Please select 2 to 12 photos from the home page.',
      name: 'editorPhotoSelectionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Discard your edits?`
  String get editorDiscardTitle {
    return Intl.message(
      'Discard your edits?',
      name: 'editorDiscardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your current collage won't be saved after you go back, and you'll need to edit it again.`
  String get editorDiscardMessage {
    return Intl.message(
      'Your current collage won\'t be saved after you go back, and you\'ll need to edit it again.',
      name: 'editorDiscardMessage',
      desc: '',
      args: [],
    );
  }

  /// `Keep editing`
  String get editorKeepEditing {
    return Intl.message(
      'Keep editing',
      name: 'editorKeepEditing',
      desc: '',
      args: [],
    );
  }

  /// `Discard and go back`
  String get editorDiscardAndLeave {
    return Intl.message(
      'Discard and go back',
      name: 'editorDiscardAndLeave',
      desc: '',
      args: [],
    );
  }

  /// `Select photos again?`
  String get editorReselectTitle {
    return Intl.message(
      'Select photos again?',
      name: 'editorReselectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Selecting photos again will clear your current collage layout and edits.`
  String get editorReselectMessage {
    return Intl.message(
      'Selecting photos again will clear your current collage layout and edits.',
      name: 'editorReselectMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select again`
  String get editorReselectPhotos {
    return Intl.message(
      'Select again',
      name: 'editorReselectPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Permission error`
  String get permissionError {
    return Intl.message(
      'Permission error',
      name: 'permissionError',
      desc: '',
      args: [],
    );
  }

  /// `Album permission required to save`
  String get albumPermissionRequired {
    return Intl.message(
      'Album permission required to save',
      name: 'albumPermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Image saved to album`
  String get imageSavedToAlbum {
    return Intl.message(
      'Image saved to album',
      name: 'imageSavedToAlbum',
      desc: '',
      args: [],
    );
  }

  /// `Save failed: {error}`
  String saveFailed(String error) {
    return Intl.message(
      'Save failed: $error',
      name: 'saveFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Image processing failed`
  String get imageProcessingFailed {
    return Intl.message(
      'Image processing failed',
      name: 'imageProcessingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Age restriction`
  String get ageRestrictionTitle {
    return Intl.message(
      'Age restriction',
      name: 'ageRestrictionTitle',
      desc: '',
      args: [],
    );
  }

  /// `You must be at least 18 years old to use this feature`
  String get ageRestrictionMessage {
    return Intl.message(
      'You must be at least 18 years old to use this feature',
      name: 'ageRestrictionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Crop image`
  String get clipTitle {
    return Intl.message(
      'Crop image',
      name: 'clipTitle',
      desc: '',
      args: [],
    );
  }

  /// `Loading image...`
  String get clipLoadingImage {
    return Intl.message(
      'Loading image...',
      name: 'clipLoadingImage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get clipCancelTooltip {
    return Intl.message(
      'Cancel',
      name: 'clipCancelTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Reset crop area`
  String get clipResetTooltip {
    return Intl.message(
      'Reset crop area',
      name: 'clipResetTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get clipDoneTooltip {
    return Intl.message(
      'Done',
      name: 'clipDoneTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Rectangle`
  String get shapeRectangle {
    return Intl.message(
      'Rectangle',
      name: 'shapeRectangle',
      desc: '',
      args: [],
    );
  }

  /// `Rounded`
  String get shapeRoundedRectangle {
    return Intl.message(
      'Rounded',
      name: 'shapeRoundedRectangle',
      desc: '',
      args: [],
    );
  }

  /// `Circle`
  String get shapeCircle {
    return Intl.message(
      'Circle',
      name: 'shapeCircle',
      desc: '',
      args: [],
    );
  }

  /// `Heart`
  String get shapeHeart {
    return Intl.message(
      'Heart',
      name: 'shapeHeart',
      desc: '',
      args: [],
    );
  }

  /// `Star`
  String get shapeStar {
    return Intl.message(
      'Star',
      name: 'shapeStar',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingTitle {
    return Intl.message(
      'Settings',
      name: 'settingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get settingSectionPurchase {
    return Intl.message(
      'Purchase',
      name: 'settingSectionPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Remove ads`
  String get settingRemoveAds {
    return Intl.message(
      'Remove ads',
      name: 'settingRemoveAds',
      desc: '',
      args: [],
    );
  }

  /// `Unlocked`
  String get settingUnlocked {
    return Intl.message(
      'Unlocked',
      name: 'settingUnlocked',
      desc: '',
      args: [],
    );
  }

  /// `One-time purchase, remove forever`
  String get settingOneTimePurchaseForever {
    return Intl.message(
      'One-time purchase, remove forever',
      name: 'settingOneTimePurchaseForever',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get settingSectionAbout {
    return Intl.message(
      'About',
      name: 'settingSectionAbout',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get settingVersion {
    return Intl.message(
      'Version',
      name: 'settingVersion',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get settingContactUs {
    return Intl.message(
      'Contact us',
      name: 'settingContactUs',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy & Terms`
  String get settingPrivacyPolicyAndTerms {
    return Intl.message(
      'Privacy Policy & Terms',
      name: 'settingPrivacyPolicyAndTerms',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to remove all ads`
  String get subscriptionEntrySubtitle {
    return Intl.message(
      'Subscribe to remove all ads',
      name: 'subscriptionEntrySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Ad-free subscription`
  String get subscriptionTitle {
    return Intl.message(
      'Ad-free subscription',
      name: 'subscriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy PicGrid without ads`
  String get subscriptionHeadline {
    return Intl.message(
      'Enjoy PicGrid without ads',
      name: 'subscriptionHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription is our greatest support, motivating us to continuously improve PicGrids and bring you a better creative experience.`
  String get subscriptionDescription {
    return Intl.message(
      'Your subscription is our greatest support, motivating us to continuously improve PicGrids and bring you a better creative experience.',
      name: 'subscriptionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Remove all ads`
  String get subscriptionBenefitNoAds {
    return Intl.message(
      'Remove all ads',
      name: 'subscriptionBenefitNoAds',
      desc: '',
      args: [],
    );
  }

  /// `Use every collage feature without interruptions`
  String get subscriptionBenefitUninterrupted {
    return Intl.message(
      'Use every collage feature without interruptions',
      name: 'subscriptionBenefitUninterrupted',
      desc: '',
      args: [],
    );
  }

  /// `Subscription plan coming soon`
  String get subscriptionPlanPreparing {
    return Intl.message(
      'Subscription plan coming soon',
      name: 'subscriptionPlanPreparing',
      desc: '',
      args: [],
    );
  }

  /// `Ad-free subscription is active`
  String get subscriptionActive {
    return Intl.message(
      'Ad-free subscription is active',
      name: 'subscriptionActive',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe now`
  String get subscriptionButton {
    return Intl.message(
      'Subscribe now',
      name: 'subscriptionButton',
      desc: '',
      args: [],
    );
  }

  /// `Restore purchases`
  String get subscriptionRestore {
    return Intl.message(
      'Restore purchases',
      name: 'subscriptionRestore',
      desc: '',
      args: [],
    );
  }

  /// `The store will display the final price and billing period. Auto-renewing subscriptions can be canceled in your store account settings.`
  String get subscriptionRenewalNotice {
    return Intl.message(
      'The store will display the final price and billing period. Auto-renewing subscriptions can be canceled in your store account settings.',
      name: 'subscriptionRenewalNotice',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions are currently available on Android only.`
  String get subscriptionAndroidOnly {
    return Intl.message(
      'Subscriptions are currently available on Android only.',
      name: 'subscriptionAndroidOnly',
      desc: '',
      args: [],
    );
  }

  /// `Google Play is currently unavailable.`
  String get subscriptionStoreUnavailable {
    return Intl.message(
      'Google Play is currently unavailable.',
      name: 'subscriptionStoreUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `The subscription plan was not found. Install the app through the internal testing link and confirm that your account is an approved tester.`
  String get subscriptionProductUnavailable {
    return Intl.message(
      'The subscription plan was not found. Install the app through the internal testing link and confirm that your account is an approved tester.',
      name: 'subscriptionProductUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Restoring purchases…`
  String get subscriptionRestoring {
    return Intl.message(
      'Restoring purchases…',
      name: 'subscriptionRestoring',
      desc: '',
      args: [],
    );
  }

  /// `Purchase restoration check completed.`
  String get subscriptionRestoreFinished {
    return Intl.message(
      'Purchase restoration check completed.',
      name: 'subscriptionRestoreFinished',
      desc: '',
      args: [],
    );
  }

  /// `Purchases could not be restored. Please try again later.`
  String get subscriptionRestoreFailed {
    return Intl.message(
      'Purchases could not be restored. Please try again later.',
      name: 'subscriptionRestoreFailed',
      desc: '',
      args: [],
    );
  }

  /// `Your transaction is being processed…`
  String get subscriptionPurchasePending {
    return Intl.message(
      'Your transaction is being processed…',
      name: 'subscriptionPurchasePending',
      desc: '',
      args: [],
    );
  }

  /// `Subscription successful. Ads have been removed.`
  String get subscriptionPurchaseSuccess {
    return Intl.message(
      'Subscription successful. Ads have been removed.',
      name: 'subscriptionPurchaseSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Purchase canceled.`
  String get subscriptionPurchaseCanceled {
    return Intl.message(
      'Purchase canceled.',
      name: 'subscriptionPurchaseCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Purchase failed. Please try again later.`
  String get purchaseFailed {
    return Intl.message(
      'Purchase failed. Please try again later.',
      name: 'purchaseFailed',
      desc: '',
      args: [],
    );
  }

  /// `Layer list (drag to reorder)`
  String get layerListTitle {
    return Intl.message(
      'Layer list (drag to reorder)',
      name: 'layerListTitle',
      desc: '',
      args: [],
    );
  }

  /// `No overlay items`
  String get layerListEmpty {
    return Intl.message(
      'No overlay items',
      name: 'layerListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Layer {index}`
  String layerItem(int index) {
    return Intl.message(
      'Layer $index',
      name: 'layerItem',
      desc: '',
      args: [index],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
