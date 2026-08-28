import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pic_grid/services/ad_visibility_service.dart';

class SettingViewController extends GetxController {
  final RxString appVersion = ''.obs;

  /// 是否已購買去除廣告。
  final RxBool isAdRemoved = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadAppVersion();
    isAdRemoved.value = AdVisibilityService.instance.isSubscribed;
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = packageInfo.buildNumber.isEmpty
          ? packageInfo.version
          : '${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (_) {
      appVersion.value = '-';
    }
  }

  /// 在 IAP 購買或恢復購買驗證完成後更新本地權限快取。
  Future<void> updateAdRemovedStatus(bool isRemoved) async {
    await AdVisibilityService.instance.setSubscribed(isRemoved);
    isAdRemoved.value = isRemoved;
  }
}
