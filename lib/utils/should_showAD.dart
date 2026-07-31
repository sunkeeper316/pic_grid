import 'dart:math';
import 'package:get/get.dart';

class AdDisplayDecision {
  static final Map<String, bool> _adDecisionCache = {};
  static final RxString appShowAds = "N".obs;

  static const String message = 'message';
  static const String uploadPhoto = 'upload_photo';
  static const String communityPhoto = 'community_photo';

  /// 決定是否要顯示廣告（根據 userId、功能 key、性別）
  static bool shouldShowAd({
    required int userId,
    required String featureKey, // 功能代碼，例如 message、upload_photo、community_photo
    required int? gender,
  }) {
    if (appShowAds.value != "Y") return false;

    final cacheKey = _buildCacheKey(userId, featureKey);
    if (_adDecisionCache.containsKey(cacheKey)) {
      return _adDecisionCache[cacheKey]!;
    }

    final result = _calculateAdChance(gender, featureKey);
    _adDecisionCache[cacheKey] = result;
    return result;
  }

  /// 根據不同功能給不同的顯示機率邏輯
  static bool _calculateAdChance(int? gender, String featureKey) {
    final random = Random();

    if (featureKey == message) {
      if (gender == 0) return random.nextDouble() < 0.1;
      if (gender == 2) return random.nextDouble() < 0.5;
    }

    if (featureKey == uploadPhoto) {
      if (gender == 0) return random.nextDouble() < 0.1;
      if (gender == 2) return random.nextDouble() < 0.8;
    }

    if (featureKey == communityPhoto) {
      if (gender == 0) return random.nextDouble() < 0.1;
      if (gender == 2) return random.nextDouble() < 0.7;
    }

    return true; // 預設都顯示
  }

  /// 清除特定使用者在某功能的快取
  static void resetForUserFeature(int userId, String featureKey) {
    final cacheKey = _buildCacheKey(userId, featureKey);
    _adDecisionCache.remove(cacheKey);
  }

  /// 全部重設
  static void resetAll() {
    _adDecisionCache.clear();
  }

  static String _buildCacheKey(int userId, String featureKey) => '$featureKey-$userId';
}
