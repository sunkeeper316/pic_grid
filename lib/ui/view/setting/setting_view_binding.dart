import 'package:get/get.dart';
import 'package:pic_grid/ui/view/setting/setting_view_controller.dart';

class SettingViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingViewController());
  }
}
