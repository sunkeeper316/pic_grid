import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  /// 將 UTC 時間字符串轉換為用戶友好的顯示格式
  ///
  /// 顯示規則：
  /// - 1小時內：顯示分鐘
  /// - 24小時內：顯示小時
  /// - 7天內：顯示天數
  /// - 同年：顯示月/日
  /// - 不同年：顯示年/月/日
  static String formatTimeForDisplay(String utcTimeString) {
    // print('📶📶📶 utcTimeString ${utcTimeString}');
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd HH:mm:ss")
          .parseUtc(utcTimeString);
      final DateTime localDateTime = parsedDate.toLocal();
      final DateTime now = DateTime.now();
      // print('📶📶📶 localDateTime ${localDateTime}');
      final Duration difference = now.difference(localDateTime);
      final int minutesDiff = difference.inMinutes;

      if (minutesDiff < 60) {
        return '$minutesDiff 分鐘前';
      } else if (minutesDiff < 24 * 60) {
        return '${difference.inHours} 小時前';
      } else if (minutesDiff < 7 * 24 * 60) {
        return '${difference.inDays} 天前';
      } else if (localDateTime.year == now.year) {
        return DateFormat('MM/dd').format(localDateTime);
      } else {
        return DateFormat('yyyy/MM/dd').format(localDateTime);
      }
    } catch (e) {
      debugPrint('時間解析錯誤: $e');
      return '';  // 或返回一個預設值
    }
  }

  /// 獲取相對時間描述
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return '剛剛';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} 分鐘前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} 小時前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} 天前';
    } else if (dateTime.year == now.year) {
      return DateFormat('MM/dd').format(dateTime);
    } else {
      return DateFormat('yyyy/MM/dd').format(dateTime);
    }
  }

  /// 檢查是否為今天
  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// 檢查是否為本週
  static bool isThisWeek(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inDays;
    return difference < 7;
  }

  static String formatMessageDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return '今天';
    } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return '昨天';
    } else if (date.year == today.year) {
      // 同年只顯示月日
      return '${date.month}月${date.day}日';
    } else {
      // 不同年顯示年月日
      return '${date.year}年${date.month}月${date.day}日';
    }
  }

  /// 將 DateTime 對象格式化為資料庫友好的字符串 (yyyy-MM-dd HH:mm:ss)
  static String toDbString(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  /// 將 DateTime 對象格式化為用戶友好的顯示字符串 (yyyy-MM-dd HH:mm)
  static String formatForDisplayDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  /// 將 UTC 時間字符串轉換為 'HH:mm' 格式 (轉換為當地時間)
  static String formatTimeOnly(String? utcTimeString) {
    if (utcTimeString == null || utcTimeString.isEmpty) return '';
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd HH:mm:ss").parseUtc(utcTimeString);
      final DateTime localDateTime = parsedDate.toLocal();
      return DateFormat('HH:mm').format(localDateTime);
    } catch (e) {
      debugPrint('時間解析錯誤: $e');
      return '';
    }
  }

  /// 將 UTC 時間字符串轉換為 'yyyy-MM-dd HH:mm' 格式 (轉換為當地時間)
  static String formatMeetupTime(String utcTimeString) {
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd HH:mm:ss").parseUtc(utcTimeString);
      final DateTime localDateTime = parsedDate.toLocal();
      return DateFormat('yyyy-MM-dd HH:mm').format(localDateTime);
    } catch (e) {
      debugPrint('Meetup時間解析錯誤: $e');
      return '';
    }
  }
  /// 將 UTC 時間字符串轉換為 DateTime 對象 (轉換為當地時間)
  static DateTime? parseUtcToLocal(String? utcTimeString) {
    if (utcTimeString == null || utcTimeString.isEmpty) return null;
    try {
      return DateFormat("yyyy-MM-dd HH:mm:ss").parseUtc(utcTimeString).toLocal();
    } catch (e) {
      debugPrint('時間解析錯誤: $e');
      return DateTime.tryParse(utcTimeString);
    }
  }
}