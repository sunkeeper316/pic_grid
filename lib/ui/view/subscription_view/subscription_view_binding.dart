import 'package:get/get.dart';
import 'package:pic_grid/ui/view/subscription_view/subscription_view_controller.dart';

class SubscriptionViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionViewController>(SubscriptionViewController.new);
  }
}
