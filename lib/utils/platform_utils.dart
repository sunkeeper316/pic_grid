
import 'dart:io';
import 'dart:ui';
class PlatformUtils {

  static String get source {
    if (Platform.isIOS) {
      return 'IOS';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else {
      return 'other';
    }
  }

  // 取得語言代碼
  static String get languageCode =>
      PlatformDispatcher.instance.locale.languageCode;

  // 取得國家代碼
  static String get countryCode =>
      PlatformDispatcher.instance.locale.countryCode ?? '';

  static int get sourceInt {
    if (Platform.isAndroid) {
      return 0; // Android
    } else if (Platform.isIOS) {
      return 1; // iOS
    } else {
      return 2; // Other
    }
  }
}