import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String keySecurityCode = 'SecurityCode';
  static const String keyAccountToken = 'account_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyLanguage = 'Language';
  static const String keyCheckFirstOpenApp = 'CheckFristOpenApp';
  static const String keyFilterByGender = 'FilterByGender';
  static const String keyFilterByInterest = 'FilterByInterest';
  static const String keyShowUntaggedPosts = 'ShowUntaggedPosts';
  static const String keySubscriptionStatus = 'SubscriptionStatus';
  static const String keyFilterByMeetupKind = 'FilterByMeetupKind';
  static const String keySelectedMeetupKindId = 'SelectedMeetupKindId';
  static const String keySelectedMeetupCountryId = 'SelectedMeetupCountryId';
  static const String keySelectedMeetupCityId = 'SelectedMeetupCityId';
  static const String keyFilterMeetupByGender = 'FilterMeetupByGender';
  static const String keySelectedMeetupGender = 'SelectedMeetupGender';
  static const String keyCommunityTabIndex = 'community_tab_index';
  static const String keyMessageTabIndex = 'message_tab_index';

  static Future<void> saveSecurityCode(String securityCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keySecurityCode, securityCode);
  }

  static Future<String> loadSecurityCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keySecurityCode) ?? "";
  }

  static Future<String?> getAccountToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAccountToken);
  }

  static Future<void> setAccountToken({String? token}) async {
    if (token == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyAccountToken, token);
  }

  static Future<void> removeAccountToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyAccountToken);
  }

  static Future<void> setRefreshToken({required String? token}) async {
    if (token == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyRefreshToken, token);
  }

  static Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyRefreshToken);
  }

  static Future<void> saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyLanguage, languageCode);
  }

  static Future<String> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyLanguage) ?? "";
  }

  static Future<void> saveCheckFirstOpenApp(bool check) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyCheckFirstOpenApp, check);
  }

  static Future<bool> loadCheckFirstOpenApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("CheckFristOpenApp ${prefs.getBool(keyCheckFirstOpenApp)}");
    return prefs.getBool(keyCheckFirstOpenApp) ?? true;
  }

  // 第一組：性別過濾設置
  static Future<void> saveFilterByGender(bool check) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyFilterByGender, check);
  }

  static Future<bool> loadFilterByGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("FilterByGender ${prefs.getBool(keyFilterByGender)}");
    return prefs.getBool(keyFilterByGender) ?? false;
  }

  // 第二組：興趣過濾設置
  static Future<void> saveFilterByInterest(bool check) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyFilterByInterest, check);
  }

  static Future<bool> loadFilterByInterest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("FilterByInterest ${prefs.getBool(keyFilterByInterest)}");
    return prefs.getBool(keyFilterByInterest) ?? false;
  }

  // 第三組：顯示無標籤文章設置
  static Future<void> saveShowUntaggedPosts(bool check) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyShowUntaggedPosts, check);
  }

  static Future<bool> loadShowUntaggedPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("ShowUntaggedPosts ${prefs.getBool(keyShowUntaggedPosts)}");
    return prefs.getBool(keyShowUntaggedPosts) ?? true;
  }

  // 訂閱紀錄
  static Future<void> saveSubscriptionStatus(bool check) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keySubscriptionStatus, check);
  }

  static Future<bool> loadSubscriptionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("SubscriptionStatus ${prefs.getBool(keySubscriptionStatus)}");
    return prefs.getBool(keySubscriptionStatus) ?? false;
  }

  // Meetup Filters
  static Future<void> saveFilterByMeetupKind(bool check) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyFilterByMeetupKind, check);
  }

  static Future<bool> loadFilterByMeetupKind() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyFilterByMeetupKind) ?? false;
  }

  static Future<void> saveSelectedMeetupKindId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keySelectedMeetupKindId, id);
  }

  static Future<int> loadSelectedMeetupKindId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keySelectedMeetupKindId) ?? 1;
  }

  static Future<void> saveSelectedCountryId(int? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (id == null) {
      await prefs.remove(keySelectedMeetupCountryId);
    } else {
      await prefs.setInt(keySelectedMeetupCountryId, id);
    }
  }

  static Future<int?> loadSelectedCountryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keySelectedMeetupCountryId);
  }

  static Future<void> saveSelectedCityId(int? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (id == null) {
      await prefs.remove(keySelectedMeetupCityId);
    } else {
      await prefs.setInt(keySelectedMeetupCityId, id);
    }
  }

  static Future<int?> loadSelectedCityId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keySelectedMeetupCityId);
  }

  static Future<void> saveFilterMeetupByGender(bool check) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyFilterMeetupByGender, check);
  }

  static Future<bool> loadFilterMeetupByGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyFilterMeetupByGender) ?? false;
  }

  static Future<void> saveSelectedMeetupGender(int gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keySelectedMeetupGender, gender);
  }

  static Future<int> loadSelectedMeetupGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keySelectedMeetupGender) ?? 2; // Default to All (2)
  }

  // Community Tab Index
  static Future<void> saveCommunityTabIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyCommunityTabIndex, index);
  }

  static Future<int?> loadCommunityTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyCommunityTabIndex);
  }

  // Message Tab Index
  static Future<void> saveMessageTabIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyMessageTabIndex, index);
  }

  static Future<int?> loadMessageTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyMessageTabIndex);
  }

  // Generic methods (use with caution, prefer specific methods above)
  static Future<void> saveInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}