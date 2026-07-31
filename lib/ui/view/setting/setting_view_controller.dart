import 'package:get/get.dart';

class SettingViewController extends GetxController {
  final RxString appVersion = ''.obs;

  /// 是否已購買去除廣告（之後接 in_app_purchase / 用 shared_preferences 快取狀態）
  final RxBool isAdRemoved = false.obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: 若要顯示實際版本號，可整合 package_info_plus
    appVersion.value = '1.0.0';
    // TODO: 從本地/IAP 讀取購買狀態
  }
}
