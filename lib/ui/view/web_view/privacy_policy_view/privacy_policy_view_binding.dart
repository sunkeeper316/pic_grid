import 'package:get/get.dart';
import 'package:pic_grid/ui/view/web_view/privacy_policy_view/privacy_policy_view_controller.dart';

class PrivacyPolicyViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PrivacyPolicyViewController());
  }
}
