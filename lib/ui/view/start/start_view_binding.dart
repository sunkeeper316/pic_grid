import 'package:get/get.dart';
import 'package:pic_grid/ui/view/start/start_view_controller.dart';

class StartViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartViewController());
  }
}
