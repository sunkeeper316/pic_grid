import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pic_grid/sharedpreference/sharedpreferences.dart';

class SettingViewController extends GetxController {
  final RxString appVersion = ''.obs;

  /// 是否已購買去除廣告。
  final RxBool isAdRemoved = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final results = await Future.wait<Object>([
      PackageInfo.fromPlatform(),
      SharedPreference.loadAdRemoved(),
    ]);

    final packageInfo = results[0] as PackageInfo;
    appVersion.value = packageInfo.version;
    isAdRemoved.value = results[1] as bool;
  }

  /// 在 IAP 購買或恢復購買驗證完成後更新本地權限快取。
  Future<void> updateAdRemovedStatus(bool isRemoved) async {
    await SharedPreference.saveAdRemoved(isRemoved);
    isAdRemoved.value = isRemoved;
  }
}
